#!/bin/env bash
s=$(python3 ~/sts.py -u lohse -b 2>/dev/null | tail -1 )
if [[ $s =~ ^[0-9/+.]+$ ]]; then 
    echo $s > ~/stregdollars
    product=$(echo ':q' | python3 ~/sts.py -l 2> /dev/null | tail -n +5 | head -1)
    product=${product% *}
    price=${product##* }
    product=${product% *}
    product=${product#* }
    product=${product#* }
    product=${product#* }
    product=${product#* }
    slice="${product%%* }"
    product=$(echo $product | sed 's/^\ *//g')
    number=$(echo ":q" | python3 ~/sts.py -u lohse | grep "$product")
    number=${number%% *}
fi
wait
if [[ $# > 0 ]]; then
    case $1 in
        "refill")
            foot -a floater bash -c 'echo "How many dollars do you want to input?"
                read amount 
                python3 ~/sts.py -u lohse -p $amount || python3 ~/sts.py -u lohse -p 100
                read'
            ;;
        "buy")
            foot -a floater bash -c "python3 ~/sts.py -u lohse"
            ;;
        "buy_latest")
            foot -a floater bash -c "echo 'Do you want to buy $number - $product, for $price dollars? [y/n]' ;
                read i ;
                case \$i in
                    [^Yy]*) exit 0 ;;
                esac ;
                python3 ~/sts.py -u lohse -i $number ;
                echo 'Gratz! you just bought $product for $price!' ;
                read
                "
            ;;
        *)
            exit 69
        esac
    exit 0
fi

d=$(cat ~/stregdollars)
num=$(bc <<< "$d/$price")
if [ $( echo "$num < 1" | bc ) -eq 1 ]; then
    echo \{\"text\": \"$d\",\"percentage\": $d, \"class\": \"critical\", \
        \"tooltip\": \"NO \'$product\' CAN BE BOUGHT!!!!!!!!\"\}
else
    echo \{\"text\": \"$d\",\"percentage\": $d, \"class\": \"good\", \
        \"tooltip\": \"$num \* \'$product\' can be bought!\"\}
fi

