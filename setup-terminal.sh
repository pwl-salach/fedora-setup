install_if_needed() {
  pck=$1
  exec_pck=$2
  if [ -z "$exec_pck" ]; then
    exec_pck=$pck
  fi
  echo "Ensuring $pck is installed"
  if which $exec_pck &>/dev/null; then
    echo "$exec_pck is already available"
    return
  fi
  echo "${pck} not installed"
  if ! which dnf &>/dev/null; then
    echo "dnf not found, make sure to install $pck manually"
  elif dnf list installed $pck &>/dev/null; then
    echo "Installing ${pck}"
    sudo dnf install -y $pck
  fi
}

install_if_needed alacritty
mkdir -p ~/.config/alacritty/
ln -sf $PWD/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $PWD/configs/.tmux.conf ~/.tmux.conf

VAR_LINE="export SETUP_REPO_PATH=\"$PWD\""
if [ -f "$HOME/.bash_profile" ]; then
  profile_file="$HOME/.bash_profile"
elif [ -f "$HOME/zprofile" ]; then
  profile_file="$HOME/.zprofile"
else
  profile_file="$HOME/.profile"
fi

echo "Using profile file: $profile_file"
if ! grep -Fxq "$VAR_LINE" "$profile_file"; then
  echo "$VAR_LINE" >>"$profile_file"
  echo "Added SETUP_REPO_PATH to $profile_file"
else
  echo "SETUP_REPO_PATH already set in $profile_file"
fi

# mc
install_if_needed mc
mkdir -p ~/.local/share/mc/skins/
ln -sf $PWD/configs/modarin-orange.ini ~/.local/share/mc/skins/modarin-orange.ini
mkdir -p ~/.config/mc/
ln -sf $PWD/configs/mc.ini ~/.config/mc/ini
ln -sf $PWD/configs/mc.ext.ini ~/.config/mc/mc.ext.ini
#sed -i '/^\[Midnight-Commander\]/,/^\[/{s/^\s*skin\s*=.*/skin=modarin-orange/;}' ~/.config/mc/ini

install_if_needed ImageMagick identify
install_if_needed img2sixel

# nvim
install_if_needed neovim nvim
ln -sfn $PWD/configs/nvim ~/.config/nvim
ln -sf $PWD/configs/starship.toml ~/.config/starship.toml

echo 123 | grep -oP "\d+" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  grep "ggrep" ~/.zshenv >/dev/null
  if [ $? -ne 0 ]; then
    echo "alias grep='ggrep'" >>~/.zshenv
    echo "Added alias for ggrep"
  fi
fi
