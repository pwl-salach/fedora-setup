install_if_needed() {
  pck=$1
  exec_pck=$2
  if [ -z "$exec_pck" ]; then
    exec_pck=$pck
  fi
  echo "Ensuring $pck is installed"
  if which $exec_pck &>/dev/null; then
    echo "$exec_pck is already installed"
    return
  fi
  if ! which dnf &>/dev/null; then
    echo "dnf not found, make sure to install $pck manually"
  elif ! dnf list installed $pck &>/dev/null; then
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
ln -sf $PWD/configs/modarin-orange.ini ~/.local/share/mc/skins/modarin-orange.ini
sed -i '/^\[Midnight Commander\]/,/^\[/{s/^skin\s*=.*/skin=modarin-orange/;t;}' ~/.config/mc/ini

# nvim
install_if_needed neovim nvim
ln -sf $PWD/configs/nvim ~/.config/nvim
