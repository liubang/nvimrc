#!/bin/bash
# copyed from https://github.com/hardcoreplayers/dotfiles/blob/master/fonts/install.sh

# Set source and target directories
powerline_fonts_dir=$(cd "$(dirname "$0")" && pwd)

find_command="find \"$powerline_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

case "$OSTYPE" in
  darwin*)
    OS="macos"
    font_dir="$HOME/Library/Fonts"
    ;;
  linux*)
    OS="linux"
    font_dir="/usr/share/fonts/custom"
    ;;
esac

# Copy all fonts to user fonts directory
echo "Copying fonts..."
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if command -v fc-cache @ >/dev/null; then
  echo "Resetting font cache, this may take a moment..."
  fc-cache -f $font_dir
fi

echo "All  fonts installed to $font_dir"
