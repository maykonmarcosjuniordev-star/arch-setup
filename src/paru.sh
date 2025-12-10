# verify if paru is installed
if command -v paru &> /dev/null
then
    echo "paru is already installed"
    exit 0
fi
echo "installing paru and configuring it"
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm
cd ..
rm -rf paru-bin

echo "configuring paru"
paru --gendb
echo "setting paru configuration"
mkdir -p ~/.config/paru/
# rewrites the paru.conf to point to the user's pacman.conf absolute path, regardless of the username
sed -i "s|^PacmanConf =.*|PacmanConf = $HOME/.config/pacman.conf|" ~/arch-setup/config/aur/paru.conf
ln -sfn ~/arch-setup/config/aur/paru.conf ~/.config/paru/paru.conf

# set paru configuration to use all cores for building packages
# Update package database and upgrade all packages
paru -Suy

# Usage:                                                                                                                                                                                                
#     paru                                                                                                                                                                                              
#     paru <operation> [...]                                                                                                                                                                            
#     paru <package(s)>                                                                                                                                                                                 
                                                                                                                                                                                                      
# Pacman operations:                                                                                                                                                                                    
#     paru {-h --help}                                                                                                                                                                                  
#     paru {-V --version}                                                                                                                                                                               
#     paru {-D --database}    <options> <package(s)>                                                                                                                                                    
#     paru {-F --files}       [options] [package(s)]                                                                                                                                                    
#     paru {-Q --query}       [options] [package(s)]                                                                                                                                                    
#     paru {-R --remove}      [options] <package(s)>                                                                                                                                                    
#     paru {-S --sync}        [options] [package(s)]                                                                                                                                                    
#     paru {-T --deptest}     [options] [package(s)]                                                                                                                                                    
#     paru {-U --upgrade}     [options] [file(s)]                                                                                                                                                       
                                                                                                                                                                                                      
# New operations:                                                                                                                                                                                       
#     paru {-P --show}        [options]                                                                                                                                                                 
#     paru {-G --getpkgbuild} [package(s)]                                                                                                                                                              
#     paru {-B --build}       [dir(s)]                                                                                                                                                                  
                                                                                                                                                                                                      
# If no arguments are provided 'paru -Syu' will be performed                                                                                                                                            
                                                                                                                                                                                                      
# Options without operation:                                                                                                                                                                            
#     -c --clean            Remove unneeded dependencies                                                                                                                                                
#        --gendb            Generates development package DB used for updating                                                                                                                          
                                                                                                                                                                                                      
# New options:                                                                                                                                                                                          
#        --repo              Assume targets are from the repositories                                                                                                                                   
#        --pkgbuilds         Assume targets are from pkgbuild repositories                                                                                                                              
#     -a --aur               Assume targets are from the AUR                                                                                                                                            
#     --mode      <mode>     Sets where paru looks for targets                                                                                                                                          
#     --interactive          Enable interactive package selection for -S, -R, -Ss and -Qs                                                                                                               
#     --aururl    <url>      Set an alternative AUR URL                                                                                                                                                 
#     --aurrpcur  <url>      Set an alternative URL for the AUR /rpc endpoint                                                                                                                           
#     --clonedir  <dir>      Directory used to download and run PKGBUILDs                                                                                                                               
                                                                                                                                                                                                      
#     --makepkg   <file>     makepkg command to use                                                                                                                                                     
#     --mflags    <flags>    Pass arguments to makepkg                                                                                                                                                  
#     --pacman    <file>     pacman command to use                                                                                                                                                      
#     --git       <file>     git command to use                                                                                                                                                         
#     --gitflags  <flags>    Pass arguments to git                                                                                                                                                      
#     --sudo      <file>     sudo command to use                                                                                                                                                        
#     --sudoflags <flags>    Pass arguments to sudo                                                                                                                                                     
#     --pkgctl    <file>     pkgctl command to use                                                                                                                                                      
#     --bat       <file>     bat command to use                                                                                                                                                         
#     --batflags  <flags>    Pass arguments to bat                                                                                                                                                      
#     --gpg       <file>     gpg command to use                                                                                                                                                         
#     --gpgflags  <flags>    Pass arguments to gpg                                                                                                                                                      
#     --fm        <file>     File manager to use for PKGBUILD review                                                                                                                                    
#     --fmflags   <flags>    Pass arguments to file manager                                                                                                                                             
                                                                                                                                                                                                      
#     --completioninterval   <n> Time in days to refresh completion cache                                                                                                                               
#     --sortby    <field>    Sort AUR results by a specific field during search                                                                                                                         
#     --searchby  <field>    Search for packages using a specified field                                                                                                                                
#     --limit     <limit>    Limits the number of items returned in a search                                                                                                                            
#     -x --regex             Enable regex for aur search                                                                                                                                                
                                                                                                                                                                                                      
#     --skipreview           Skip the review process                                                                                                                                                    
#     --review               Don't skip the review process                                                                                                                                              
#     --[no]upgrademenu      Show interactive menu to skip upgrades                                                                                                                                     
#     --[no]removemake       Remove makedepends after install                                                                                                                                           
#     --[no]cleanafter       Remove package sources after install                                                                                                                                       
#     --[no]rebuild          Always build target packages                                                                                                                                               
#     --[no]redownload       Always download PKGBUILDs of targets                                                                                                                                       
                                                                                                                                                                                                      
#     --[no]pgpfetch         Prompt to import PGP keys from PKGBUILDs                                                                                                                                   
#     --[no]useask           Automatically resolve conflicts using pacman's ask flag                                                                                                                    
#     --[no]savechanges      Commit changes to pkgbuilds made during review                                                                                                                             
#     --[no]newsonupgrade    Print new news during sysupgrade                                                                                                                                           
#     --[no]combinedupgrade  Refresh then perform the repo and AUR upgrade together                                                                                                                     
#     --[no]batchinstall     Build multiple AUR packages then install them together                                                                                                                     
#     --[no]provides         Look for matching providers when searching for packages                                                                                                                    
#     --[no]devel            Check development packages during sysupgrade                                                                                                                               
#     --[no]installdebug     Also install debug packages when a package provides them                                                                                                                   
#     --[no]sudoloop         Loop sudo calls in the background to avoid timeout                                                                                                                         
#     --[no]chroot           Build packages in a chroot                                                                                                                                                 
#     --[no]failfast         Exit as soon as building an AUR package fails                                                                                                                              
#     --[no]keepsrc          Keep src/ and pkg/ dirs after building packages                                                                                                                            
#     --[no]sign             Sign packages with gpg                                                                                                                                                     
#     --[no]signdb           Sign databases with gpg                                                                                                                                                    
#     --[no]localrepo        Build packages into a local repo                                                                                                                                           
#     --nocheck              Don't resolve checkdepends or run the check function                                                                                                                       
#     --develsuffixes        Suffixes used to decide if a package is a devel package                                                                                                                    
#     --ignoredevel          Ignore devel upgrades for specified packages                                                                                                                               
#     --bottomup             Shows AUR's packages first and then repository's                                                                                                                           
#     --topdown              Shows repository's packages first and then AUR's                                                                                                                           
                                                                                                                                                                                                      
# show specific options:                                                                                                                                                                                
#     -c --complete         Used for completions                                                                                                                                                        
#     -s --stats            Display system package statistics                                                                                                                                           
#     -w --news             Print arch news                                                                                                                                                             
                                                                                                                                                                                                      
# getpkgbuild specific options:                                                                                                                                                                         
#     -p --print            Print pkgbuild to stdout                                                                                                                                                    
#     -c --comments         Print AUR comments for pkgbuild                                                                                                                                             
#     -s --ssh              Clone package using SSH                                                                                                                                                     
                                                                                                                                                                                                      
# Build specific options:                                                                                                                                                                               
#     -i --install          Install package as well as building