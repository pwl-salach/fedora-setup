MAIN_WORKDIR=$(pwd)

mkdir -p $MAIN_WORKDIR/external
cd $MAIN_WORKDIR/external

# install dependencies
sudo dnf install -y gnome-tweaks gnome-themes-extra sassc gtk-murrine-engine gnome-shell-extension-user-theme

# color theme
git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
cd Gruvbox-GTK-Theme/themes/
./install.sh --theme orange --color dark --libadwaita --tweaks medium float outline

# icon theme
git clone https://github.com/SylEleuth/gruvbox-plus-icon-pack.git
cd gruvbox-plus-icon-pack
cp -r Gruvbox-Plus-Dark ~/.local/share/icons
cd scripts
chmod +x folders-color-chooser
./folders-color-chooser --color=pumpkin

cd $MAIN_WORKDIR
rm -rf $MAIN_WORKDIR/external

gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
# apply settings
gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Orange-Dark-Medium'
gsettings set org.gnome.shell.extensions.user-theme name 'Gruvbox-Orange-Dark-Medium'
gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Plus-Dark'
