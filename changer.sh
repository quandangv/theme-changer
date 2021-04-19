cd $(dirname $0)
config_termite="templates/termite  ~/.config/termite/config"
config_kitty="templates/kitty  ~/.config/kitty/kitty.conf"
config_alacritty="templates/alacritty ~/.config/alacritty/alacritty.yml"
config_kakoune="templates/kakoune  ~/.config/kak/colors/default.kak"
config_bspwm="templates/bspwm      ~/.config/kak/bspwmrc"
config_yuzubar="templates/yuzubar  ~/.config/yuzubar/default.yzb"
config_fehbg="templates/fehbg      ~/.fehbg"
config_neofetch="templates/neofetch ~/.config/neofetch/config.conf"

cmd="linked_replace -i \"$1\" $config_kitty $config_neofetch $config_kakoune $config_bspwm $config_fehbg $config_yuzubar"
echo $cmd
eval $cmd

# Reload kitty
# kitty must have been started using `kitty -o allow_remote_control=yes --listen-on unix:/tmp/kitty-color` for this to work
kitty @ --to unix:/tmp/kitty-color set-colors --all ~/.config/kitty/kitty.conf
kitty @ --to unix:/tmp/kitty-color set-background-opacity --all `cat ~/.config/kitty/kitty.conf | grep ^background_opacity | awk  '{print $2}'`

# Reload fehbg
~/.fehbg

# Reload bspwm
bspc wm -r

# Reload yuzubar
pkill --signal USR1 yuzubar

# Reload kakoune
while IFS= read -r line; do
  if [[ "$line" != *"(dead)"* ]]; then
    echo colorscheme default | kak -p $line
  fi
done < <(kak -l)
