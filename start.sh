# Wifi may interfere with Bluetooth:
# sudo rfkill block/unblock wlan
# sudo ifconfig wlan0 down/up
# If hcitool lescan complains:
# sudo systemctl restart bluetooth

file=~/Owon-Multimeters/code/owon_multi_cli
owon_address=A5:B3:C2:20:08:79

check_sercona_Owon-Multimeters() {
  if [ ! -f "$file" ]; then
    echo "File not found, cloning github project."    
    git clone https://github.com/sercona/Owon-Multimeters.git ~/Owon-Multimeters
#   Building project
    cd ~/Owon-Multimeters/code || exit
    make
  fi

  if [ ! -f "$file" ]; then
    echo "Error: Missing file $file"  
    exit 1
  fi
}

measure() {
  echo "Press q to quit, s for device selection or any other key to measure."
  while true; do
    read -n 1 input
    if [ "$input" = "s" ]; then
      device_selection
    elif [ "$input" = "q" ]; then
      echo -e "\nBye."
      break
    fi
    sudo $file -a $owon_address -t ow18e -1 | awk '{$1=""; sub(/^ /, ""); print}'
  done
}

device_selection() {
  echo -e "\nScanning for devices, please wait."
  lines=()

  while IFS= read -r line; do
    lines+=("$line")
  done < <(timeout --signal=2 --foreground --preserve-status 10s sudo hcitool lescan)

  echo -e "\n=== Device Selection ==="
  for i in "${!lines[@]}"; do
    echo "$((i+1)). ${lines[i]}"
  done

  read -p "Device: " selection

  selected_line=${lines[$((selection-1))]}
  address=$(echo "$selected_line" | awk '{print $1}')
  echo -e "\n$address selected\n"
  sed -i 's/^owon_address=.*/owon_address='"$address"'/g' start.sh
  sudo systemctl restart bluetooth
  echo "Please restart script."
  exit 0
}

main() {
check_sercona_Owon-Multimeters
measure
}

main
