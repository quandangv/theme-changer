config_termite="templates/termite  ~/.config/termite/config"
config_kakoune="templates/kakoune  ~/.config/kak/colors/default.kak"
config_bspwm="templates/bspwm      ~/.config/kak/bspwmrc"
config_yuzubar="templates/yuzubar  ~/.config/yuzubar/default.yzb"
config_fehbg="templates/fehbg      ~/.fehbg"

cmd="linked_replace -i \"$1\" $config_termite $config_kakoune $config_bspwm $config_fehbg $config_yuzubar"
echo $cmd
eval $cmd

# Reload termite
pkill --signal USR1 termite

# Reload yuzubar
pkill --signal USR1 yuzubar

# Reload bspwm
bspc wm -r

# Reload fehbg
~/.fehbg

# Reload kakoune
while IFS= read -r line; do
  if [[ "$line" != *"(dead)"* ]]; then
    echo colorscheme default | kak -p $line
  fi
done < <(kak -l)
