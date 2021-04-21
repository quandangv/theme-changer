cd $(dirname $0)

config_cmd="linkt_replace -i \"$1\" "
reload_cmd=""

# Comment out the tools you don't use and uncomment the tools you use

# kitty
config_cmd+="templates/kitty ~/.config/kitty/kitty.conf "
reload_cmd+="
  kitty @ --to unix:/tmp/kitty-color set-colors --all ~/.config/kitty/kitty.conf;
  kitty @ --to unix:/tmp/kitty-color set-background-opacity --all `cat ~/.config/kitty/kitty.conf | grep ^background_opacity | awk  '{print $2}'`;
"

# bspwm
config_cmd+="templates/bspwm ~/.config/kak/bspwmrc "
reload_cmd+="bspc wm -r;"

# fehbg
config_cmd+="templates/fehbg ~/.fehbg "
reload_cmd+="~/.fehbg;"

# yuzubar
config_cmd+="templates/yuzubar ~/.config/yuzubar/default.yzb "
reload_cmd+="pkill --signal USR1 yuzubar;"

# kakoune
config_cmd+="templates/kakoune ~/.config/kak/colors/default.kak "
reload_cmd+='
while IFS= read -r line; do
  if [[ "$line" != *"(dead)"* ]]; then
    echo colorscheme default | kak -p $line;
  fi;
done < <(kak -l);
'

# neofetch
config_cmd+="templates/neofetch ~/.config/neofetch/config.conf "

# termite
#config_cmd+="templates/termite  ~/.config/termite/config "
#reload_cmd+="pkill --signal USR1 termite;"

# alacritty
#config_cmd+="templates/alacritty ~/.config/alacritty/alacritty.yml"

echo Configuration command: $config_cmd
eval $config_cmd

echo Reload command: $reload_cmd
eval $reload_cmd

