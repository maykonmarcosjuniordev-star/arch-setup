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

#!/bin/bash
echo "installing yay and related apps"

# verify if yay-git directory exists
if [ ! -d /opt/yay-git ]; then
    sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
    sudo chown -R $(whoami):$(whoami) /opt/yay-git/
    cd /opt/yay-git
    makepkg -sirc
    cd ~/arch-setup
fi
echo "configuring yay"
yay -Y --gendb
echo "setting yay cofiguration flags"
yay --save --diffmenu=false --diffmenu=false --removemake=true --cleanafter=true
yay --save --answerclean A --answerdiff N --answeredit N --answerupgrade Y

# set yay configuration to use all cores for building packages

# Update package database and upgrade all packages
yay -Suy


