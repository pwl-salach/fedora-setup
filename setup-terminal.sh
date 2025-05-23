mkdir -p ~/.config/alacritty/
ln -sf $PWD/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $PWD/configs/.tmux.conf ~/.tmux.conf

# mc
if ! dnf list installed mc &>/dev/null; then
  sudo dnf install -y mc
fi
ln -sf $PWD/configs/modarin-orange.ini ~/.local/share/mc/skins/modarin-orange.ini
sed -i '/^\[Midnight Commander\]/,/^\[/{s/^skin\s*=.*/skin=modarin-orange/;t;}' ~/.config/mc/ini
