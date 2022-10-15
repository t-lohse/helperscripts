#!/bin/bash

update() {
    cd $1/ ##Change into the directory of argumented package
    git config pull.ff only
    res=$(git pull)
    if [ "$res" != "Already up to date." ]; then
        echo -e '\e[91m'${1:2}'\e[0m is updating'
        makepkg -si

    elif [ "$res" = "Already up to date." ]; then
        echo -e '\e[32m'${1:2}'\e[0m is already updated/up to date'
    fi

    cd ..  ##Exit out of diretory
}

cd $AUR_DIR
dirs=$(find -maxdepth 1 -type d)
dirs="${dirs:2}"
array=(${dirs// / })

echo -e '\e[34mUpdating AUR-packages\e[0m'
for element in "${array[@]}"; do
    update $element
done
