#!/bin/bash

devN=('Jabra' 'KILBURN II' 'Galaxy Buds+' 'My Birds')       #Device Name (No spaces)
dev=("08:C8:C2:11:75:25" "00:12:6F:54:FC:32" "34:82:C5:46:FB:B2" "C0:28:8D:1B:EE:83")   #Device MAC-address

Connect()
{
    n=${#dev[@]}
    i=0
    printf '\n\e[32mConnect to:\e[0m\n'
    while [ "$i" -lt "$n" ]
    do
        echo -e '\e[34m    ['$(( $i + 1 ))']\e[0m '${devN[$i]}''
        i=$(( $i + 1 ))
    done
    echo -e '\n    \e[91m[X]\e[0m to exit'
    printf '\n=>   '
    read x

    if [ "$x" == "X" ] || [ "$x" == "x" ]; then
        exit
    elif [ "$x" -gt "$n" ] || [ "$x" -lt "0" ]; then
        echo -e '\e[91mNot in index, try again\e[0m'
        sleep 1.5
        clear
        Connect
        exit
    fi
    mac=${dev[$(( $x - 1 ))]}

    systemctl start bluetooth
    coproc bluetoothctl
    sleep 0.5
    echo -e "power on\n" | bluetoothctl
    sleep 0.5
    echo -e "agent on\n" | bluetoothctl
    sleep 0.5
    echo -e "default-agent\n" | bluetoothctl
    sleep 0.5
    echo -e "connect "$mac"\n" | bluetoothctl
    sleep 5
    echo $(exit)

    exit
}

Start()
{
    stat=$(systemctl is-active bluetooth)
    if [ "$stat" == "inactive" ]; then
        stat="\e[91m$stat\e[0m"
    else
        stat="\e[32m$stat\e[0m"
    fi
    printf "\n\e[34mBluetooth\e[0m is currently $stat\n"
    printf '\e[32mType:\e[0m
    [1] to \e[34mopen bluetooth and start connecting\e[0m
    [2] to \e[91mstop bluetooth\e[0m
    
    [X] to exit

=>   '
    read cmd

    if [ "$cmd" == x ] || [ "$cmd" == X ]; then
        exit
    elif [ "$cmd" == "1" ]; then
        echo -e '\e[34mStarting bluetooth\e[0m'
        Connect
    elif [ "$cmd" == "2" ]; then
        systemctl stop bluetooth
        echo -e '\e[91mBluetooth stopped\e[0m'
        sleep 0.69
        exit
    else
        printf 'Please try again\n\n'
        sleep 0.5
        clear
        Start
        exit
    fi
}

#Starting program
Start
