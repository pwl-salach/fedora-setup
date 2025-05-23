MAIN_WORKDIR=$(pwd)

mkdir -p external
cd external

# install dependencies
sudo dnf install -y gnome-tweaks gnome-themes-extra sassc gtk-murrine-engine

# color theme
git clone https://github.com/vinceliuice/Colloid-gtk-theme.gitcd Colloid-gtk-theme
./install.sh --libadwaita --theme orange --color dark --tweaks black rimless

# icon theme
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
wget -qO- https://git.io/papirus-folders-install | env PREFIX=$HOME/.local sh
papirus-folders -C deeporange --theme Papirus-Dark

# apply settings
gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.shell.extensions.user-theme name 'Colloid-Orange-Dark-Dracula'
