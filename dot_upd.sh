#!/bin/bash

#"PATH/TO/DOTFILE PATH/TO/CONFIG"
dot_dir="$HOME/Documents/dotfiles"
apps=(
"$dot_dir/waybar/config $HOME/.config/waybar/config"                            #Waybar
"$dot_dir/waybar/style.css $HOME/.config/waybar/style.css"  
"$dot_dir/sway/config $HOME/.config/sway/config"                                #Sway
"$dot_dir/sway/autostart.sh $HOME/.config/sway/autostart.sh"  
"$dot_dir/foot/foot.ini $HOME/.config/foot/foot.ini"                            #Foot (Term)
"$dot_dir/neomutt/colors $HOME/.config/neomutt/colors"                          #Neomutt (Email)
"$dot_dir/neomutt/mailcap $HOME/.config/neomutt/mailcap"
"$dot_dir/neomutt/mappings $HOME/.config/neomutt/mappings"
"$dot_dir/neomutt/settings $HOME/.config/neomutt/settings"
"$dot_dir/neomutt/accounts/school $HOME/.config/neomutt/accounts/school"
"$dot_dir/neomutt/accounts/private $HOME/.config/neomutt/accounts/private"
"$dot_dir/nvim/init.vim $HOME/.config/nvim/init.vim"                            #Nvim
"$dot_dir/nvim/settings.vim $HOME/.config/nvim/settings.vim"
"$dot_dir/neofetch/config.conf $HOME/.config/neofetch/config.conf"              #neofetch
"$dot_dir/zsh/.zshrc $HOME/.zshrc"                                              #Zsh
"$dot_dir/zsh/.zshenv $HOME/.zshenv"
"$dot_dir/sirula/config.toml $HOME/.config/sirula/config.toml"
"$dot_dir/sirula/style.css $HOME/.config/sirula/style.css"
)
for app in "${apps[@]}"; do
    file=($app)
    s=$(diff ${file[0]} ${file[1]})
    state=$?
    if [[ $state == "1" ]]; then
        echo " =>  Updating ${file[0]}"
        cat ${file[1]} > ${file[0]}
    elif [[ $state == "2" ]]; then
        echo "panic"
        exit 2
    fi
done
