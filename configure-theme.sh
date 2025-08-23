MAIN_WORKDIR=$(pwd)

mkdir -p $MAIN_WORKDIR/external
cd $MAIN_WORKDIR/external

# install dependencies
sudo dnf install -y gnome-tweaks gnome-themes-extra sassc gtk-murrine-engine gnome-shell-extension-user-theme

# color theme
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
./install.sh --libadwaita --theme orange --color dark --tweaks black rimless

cd $MAIN_WORKDIR
rm -rf $MAIN_WORKDIR/external

# icon theme
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
wget -qO- https://git.io/papirus-folders-install | env PREFIX=$HOME/.local sh
papirus-folders -C deeporange --theme Papirus-Dark

gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
# apply settings
gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.shell.extensions.user-theme name 'Colloid-Orange-Dark-Dracula'
