cd $(dirname $0)

config_cmd="linkt_replace -i \"$1\" "
reload_cmd=""
change_list=""

# Comment out the tools you don't use and uncomment the tools you use

# terminator
change_list+="terminator "
config_cmd+="templates/terminator  ~/.config/terminator/config "

# kitty
change_list+="kitty "
config_cmd+="templates/kitty ~/.config/kitty/kitty.conf "
reload_cmd+="
  kitty @ --to unix:/tmp/kitty-color set-colors --all ~/.config/kitty/kitty.conf;
  kitty @ --to unix:/tmp/kitty-color set-background-opacity --all `cat ~/.config/kitty/kitty.conf | grep ^background_opacity | awk  '{print $2}'`;
"

# bspwm
change_list+="bspwm "
config_cmd+="templates/bspwm ~/.config/kak/bspwmrc "
reload_cmd+="bspc wm -r;"

# fehbg
change_list+="fehbg "
config_cmd+="templates/fehbg ~/.fehbg "
reload_cmd+="~/.fehbg;"

# nitrogen
#change_list+="nitrogen "
#config_cmd+="templates/nitrogen ~/.config/nitrogen/bg-saved.cfg "
#reload_cmd+="nitrogen --restore;"

# yuzubar
change_list+="yuzubar "
config_cmd+="templates/yuzubar ~/.config/yuzubar/default.yzb "
reload_cmd+="pkill --signal USR1 yuzubar;"

# kakoune
change_list+="kakoune "
config_cmd+="templates/kakoune ~/.config/kak/colors/default.kak "
reload_cmd+='
while IFS= read -r line; do
  if [[ "$line" != *"(dead)"* ]]; then
    echo colorscheme default | kak -p $line;
  fi;
done < <(kak -l);
'

# neofetch
change_list+="neofetch "
config_cmd+="templates/neofetch ~/.config/neofetch/config.conf "

# termite
#change_list+="termite "
#config_cmd+="templates/termite  ~/.config/termite/config "
#reload_cmd+="pkill --signal USR1 termite;"

# alacritty
#change_list+="alacritty "
#config_cmd+="templates/alacritty ~/.config/alacritty/alacritty.yml"

if [ ! -f ./confirmed ]; then
  echo This will replace the configurations of these application: $change_list
  read -r -p "$(echo "Are you sure? [y/N]: ")" -n 1 p && echo
  [[ "${p^^}" != "Y" ]] && exit 1
  touch ./confirmed
fi

echo Configuration command: $config_cmd
eval $config_cmd

echo Reload command: $reload_cmd
eval $reload_cmd

