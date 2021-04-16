termite_path=~/.config/termite
kakoune_path=~/.config/kak
bspwm_path=~/.config/kak
yuzubar_path=~/.config/yuzubar

linked_replace -i "$1" templates/termite $termite_path/config  templates/kakoune $kakoune_path/colors/default.kak templates/bspwm $bspwm_path/bspwmrc templates/fehbg ~/.fehbg templates/yuzubar $yuzubar_path/default.yzb

pkill --signal USR1 termite
pkill --signal USR1 yuzubar
bspc wm -r
~/.fehbg
while IFS= read -r line; do
  if [[ "$line" != *"(dead)"* ]]; then
    echo colorscheme default | kak -p $line
  fi
done < <(kak -l)
