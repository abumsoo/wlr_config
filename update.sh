#!/bin/sh

set -euo pipefail

CONFIG=~/.config

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Update configuration files
for config in $(ls -A ./)
do
  if [[ "$@" =~ $config ]]; then
    :
  elif [[ -d "$CONFIG/$config" || -f "$CONFIG/$config" ]]; then
    if ! cp $CONFIG/$config ./ 2> /dev/null; then
      cp -r $CONFIG/$config ./
    fi
    echo "$config copied"
  elif [[ -d "$HOME/$config" || -f "$HOME/$config" ]]; then
    if ! cp $HOME/$config ./ 2> /dev/null; then
      cp -r $HOME/$config ./
    fi
    echo "$config copied"
  fi
done

# Success message
echo ""
echo "Update finished!"
