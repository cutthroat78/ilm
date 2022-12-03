#!/bin/bash

configfile="$HOME/.config/ilm/config"
function read_csv(){
  cat "$csvfile" | grep "$1" | cut -d ',' -f"$2"
}

function get_id(){
  cat "$csvfile" | cut -d ',' -f1,2 | grep ""$1"," | cut -d ',' -f2
}

source "$configfile" &> /dev/null

default_config="csvfile=\"$HOME/.config/ilm/music.csv\"
queuefile=\"$HOME/.config/ilm/queue\"
ext_menu=\"dmenu\"
mpv_options=\"--no-video\"
remote_path=\"\"
remote_local_path=\"$HOME/.config/ilm/remote\""

if [ "$1" = "help" ]; then
  echo -e "ilm - i love music\n{add git repo link here}\n\nCommands:\nhelp - Displays this text\ninit - Setups default folder, config and csvfile (if they don't already exist)\nshow - Show csvfile contents\nshow queue - Show queuefile contents\nlink - Mount remote music share\nunlink - Unmount remote music share"
fi

if [ "$1" = "init" ]; then
  mkdir ~/.config/ilm
  if [ -f "$configfile" ]; then
    echo "$configfile already exists"
  else
    echo "$default_config" > "$configfile"
    source "$configfile"
  fi
  if [ -f "$csvfile" ]; then
    echo "$csvfile already exists"
  else
    echo "ID,Link,Song,Album,Artist,Genre,Date Added,Listens,Full Listens" >  "$csvfile"
  fi
fi

if [ "$1" = "play" ]; then
  link=$(get_id "$2")
  echo "$(read_csv ""$2"," 3) - $(read_csv ""$2"," 4) - $(read_csv ""$2"," 5))"
  notify-send "$(echo "$(read_csv ""$2"," 3) - $(read_csv ""$2"," 4) - $(read_csv ""$2"," 5))")"
  mpv $mpv_options "$link"
fi

if [ "$1" = "show" ]; then
  if [ "$2" = "queue" ]; then
    cat "$queuefile"
    exit 0
  fi
  cat "$csvfile"
fi

if [ "$1" = "link" ]; then
  mkdir "$remote_local_path"
  sshfs "$remote_path" "$remote_local_path"
fi

if [ "$1" = "unlink" ]; then
  umount "$remote_local_path" 
fi
