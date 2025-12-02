#!/bin/bash

# --answerclean   <a>   Set a predetermined answer for the clean build menu
# --answerdiff    <a>   Set a predetermined answer for the diff menu
# --answeredit    <a>   Set a predetermined answer for the edit pkgbuild menu
# --answerupgrade <a>   Set a predetermined answer for the upgrade menu
# --noanswerclean       Unset the answer for the clean build menu
# --noanswerdiff        Unset the answer for the edit diff menu
# --noansweredit        Unset the answer for the edit pkgbuild menu
# --noanswerupgrade     Unset the answer for the upgrade menu
# --cleanmenu           Give the option to clean build PKGBUILDS
# --diffmenu            Give the option to show diffs for build files
# --editmenu            Give the option to edit/view PKGBUILDS
# --askremovemake       Ask to remove makedepends after install
# --askyesremovemake    Ask to remove makedepends after install("Y" as default)
# --removemake          Remove makedepends after install
# --noremovemake        Don't remove makedepends after install

# --cleanafter          Remove package sources after successful install

# verify if yay is installed
if command -v yay &> /dev/null
then
    echo "yay is already installed"
    exit 0
fi
echo "installing yay and related apps"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin
# if [ ! -d /opt/yay-git]; then
#     sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
#     sudo chown -R $(whoami):$(whoami) /opt/yay-git/
#     cd /opt/yay-git
#     makepkg -sirc
#     cd ~/arch-setup
# fi

echo "configuring yay"
yay -Y --gendb
echo "setting yay cofiguration flags"
yay --save --diffmenu=false --diffmenu=false --removemake=true --cleanafter=true
yay --save --answerclean A --answerdiff N --answeredit N --answerupgrade A


# set yay configuration to use all cores for building packages

# Update package database and upgrade all packages
yay -Suy


