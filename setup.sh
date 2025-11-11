#!/bin/bash

# Define the software that would be installed
#Need some prep work
prep_stage=(
  qt5-wayland
  qt5ct
  qt6-wayland
  qt6ct
  qt5-svg
  qt5-quickcontrols2
  qt5-graphicaleffects
  gtk3
  polkit-gnome
  pipewire
  wireplumber
  jq
  wl-clipboard
  cliphist
  python-requests
  pacman-contrib
)

#the main packages
install_stage=(
  kitty
  mako
  waybar
  swww
  swaylock-effects
  wofi
  wlogout
  xdg-desktop-portal-hyprland
  swappy
  grim
  slurp
  thunar
  btop
  firefox
  thunderbird
  mpv
  pamixer
  pavucontrol
  brightnessctl
  bluez
  bluez-utils
  blueman
  network-manager-applet
  gvfs
  thunar-archive-plugin
  file-roller
  starship
  papirus-icon-theme
  ttf-jetbrains-mono-nerd
  noto-fonts-emoji
  lxappearance
  xfce4-settings
  nwg-look
  sddm
  # self added packages
  stow
  vim
  neovim
  zsh
  hyprlock
  htop
  fastfetch
  librewolf-bin
  nemo
  okular
  mattermost-desktop
  vesktop-bin
  keepassxc
  telegram-desktop
)

for str in ${myArray[@]}; do
  echo $str
done

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

######
# functions go here

# function that would show a progress bar to the user
show_progress() {
  while ps | grep $1 &>/dev/null; do
    echo -n "."
    sleep 2
  done
  echo -en "Done!\n"
}

# function that will test for a package and if not found it will attempt to install it
install_software() {
  # First lets see if the package is there
  if yay -Q $1 &>>/dev/null; then
    echo -e "$COK - $1 is already installed."
  else
    # no package found so installing
    echo -en "$CNT - Now installing $1 ."
    yay -S --noconfirm $1 &>>$INSTLOG &
    show_progress $!
    # test to make sure package installed
    if yay -Q $1 &>>/dev/null; then
      echo -e "\e[1A\e[K$COK - $1 was installed."
    else
      # if this is hit then a package is missing, exit to review log
      echo -e "\e[1A\e[K$CER - $1 install had failed, please check the install.log"
      exit
    fi
  fi
}

# clear the screen
clear

# let the user know that we will use sudo
echo -e "$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script."

# give the user an option to exit out
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' CONTINST
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
  echo -e "$CNT - Setup starting..."
  sudo touch /tmp/hyprv.tmp
else
  echo -e "$CNT - This script will now exit, no changes were made to your system."
  exit
fi

#### Check for package manager ####
if [ ! -f /sbin/yay ]; then
  echo -en "$CNT - Configuring yay."
  git clone https://aur.archlinux.org/yay.git &>>$INSTLOG
  cd yay
  makepkg -si --noconfirm &>>../$INSTLOG &
  show_progress $!
  if [ -f /sbin/yay ]; then
    echo -e "\e[1A\e[K$COK - yay configured"
    cd ..

    # update the yay database
    echo -en "$CNT - Updating yay."
    yay -Suy --noconfirm &>>$INSTLOG &
    show_progress $!
    echo -e "\e[1A\e[K$COK - yay updated."
  else
    # if this is hit then a package is missing, exit to review log
    echo -e "\e[1A\e[K$CER - yay install failed, please check the install.log"
    exit
  fi
fi

### Install all of the above packages ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then

  # Prep Stage - Bunch of needed items
  echo -e "$CNT - Prep Stage - Installing needed components, this may take a while..."
  for SOFTWR in ${prep_stage[@]}; do
    install_software $SOFTWR
  done

  # Install the correct hyprland version
  echo -e "$CNT - Installing Hyprland, this may take a while..."
  install_software hyprland

  # Stage 1 - main components
  echo -e "$CNT - Installing main components, this may take a while..."
  for SOFTWR in ${install_stage[@]}; do
    install_software $SOFTWR
  done

  # Start the bluetooth service
  echo -e "$CNT - Starting the Bluetooth Service..."
  sudo systemctl enable --now bluetooth.service &>>$INSTLOG

  # Enable the sddm login manager service
  echo -e "$CNT - Enabling the SDDM Service..."
  sudo systemctl enable sddm &>>$INSTLOG

  # Clean out other portals
  echo -e "$CNT - Cleaning out conflicting xdg portals..."
  yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &>>$INSTLOG
fi

#TODO: Make prompt that asks whether or not this is wanted?
echo -e "Installing oh-my-zsh and zsh plugins"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"                                       # install oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k          # powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions             # zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
echo -e "Done installing zsh plugins!"

### Script is done ###
echo -e "$CNT - Script had completed!"
if [[ "$ISNVIDIA" == true ]]; then
  echo -e "$CAT - Since we attempted to setup an Nvidia GPU the script will now end and you should reboot.
    Please type 'reboot' at the prompt and hit Enter when ready."
  exit
fi

echo -e "Run 'stow .' to create symlinks for all of the config files."
# TODO: Run stow automatically?
# TODO: Replace individual install of packages to group call to yay?
# TODO: Install hyprexpo automatically? If I even want to keep that lol
