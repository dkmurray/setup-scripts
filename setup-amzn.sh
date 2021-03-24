echo "Creating an SSH key for you..."
ssh-keygen

echo "Please add this public key to code.amazon \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff..."
xcode-select --install

echo "Login via midway and kerberos"
kinit && mwinit

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Tapping Amazon Keg..."
brew tap amazon/homebrew-amazon ssh://git.amazon.com/pkg/HomebrewAmazon
brew analytics off

echo "Installing ruby..."
brew install ruby

echo "Installing Git..."
brew install git

echo "Git config"

git config --global user.name "David Murray"
git config --global user.email dvmurray@amazon.com


echo "Installing brew git utilities..."
brew install git-extras
# brew install legit
# brew install git-flow

echo "Installing other brew stuff..."
brew install tree
brew install wget
brew install trash
brew install mackup
brew install ballast
brew install awscli
brew install ninja-dev-sync
brew install tmux
brew tap jakehilborn/jakehilborn
brew install displayplacer


echo "Installing Fonts..."
brew tap epk/epk
brew install font-sf-mono-nerd-font

echo "Cleaning up brew..."
brew cleanup

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing up powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions

# echo "Copying dotfiles from Github" # <- needs work, might not ned with mackup
# cd ~
# git clone git@github.com:dkmurray/dotfiles.git .dotfiles
# cd .dotfiles
# sh symdotfiles

echo "Installing dropbox..."
brew install --cask --appdir="/Applications" dropbox

echo "Please login to and sync Dropbox with your work account and then come back to this script."
read -p "Press [Enter] key after this..."

echo "Setting up Mackup..."
echo "[storage]" > ~/.mackup.cfg
echo "engine = dropbox" >> ~/.mackup.cfg

read -p "Would you like to restore from mackup?" yn
    case $yn in
        [Yy]* ) mackup restore; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac

echo "Setting ZSH as shell..."
chsh -s /bin/zsh
source ~/.zshrc

echo "Installing toolbox..."
/usr/bin/curl -fLSs -b ~/.midway/cookie 'https://buildertoolbox-bootstrap.s3-us-west-2.amazonaws.com/toolbox-install.sh' -o /tmp/toolbox-install.sh
/bin/bash /tmp/toolbox-install.sh
grep .toolbox ~/.zshrc || echo 'export PATH=$HOME/.toolbox/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

echo "Setting up java path..."
grep JAVA_HOME ~/.zshrc || echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ~/.zshrc
source ~/.zshrc
echo "Verify that this is thge JDK version installed from self-service"
$JAVA_HOME/bin/java -version
read -p "Press [Enter] key after verifying..."

echo "Setting up python-build"
brew install pyenv xz
python-build 3.6.10 ~/.runtimes/Python36
python-build 3.7.7 ~/.runtimes/Python37
python-build 3.8.3 ~/.runtimes/Python38

echo "Installing toolbox utilities..."
toolbox install ada cr batscli brazil-graph gordian-knot
toolbox update
echo "Please remember to install brazilcli later and set up workplace"

# echo "Installing brazilcli..."
# echo "(this will require a restart after this script finishes)"
# toolbox install brazilcli
# echo "Remember to run this after"
# read -p "Press [Enter] key after this..."

# Apps
CASKS=(
  # alfred <- look into
  # bartender <- look into
  # bettertouchtool <- look into
  disk-inventory-x
  google-chrome
  intellij-idea
  iterm2
  notion
  rectangle
  save-hollywood
  scroll-reverser
  spotify
  steermouse
  sublime-text
  suspicious-package
  vlc
)

# Install apps to /Applications
echo "Installing apps with Cask..."
brew tap homebrew/cask
for i in "${CASKS[@]}"; do
  echo "Installing ".$i
  brew install $i --cask
done
brew cleanup

echo "Setting some Mac settings..."
#"Setting key reapeat"
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

#"Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no

#"Disabline the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
# defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#"Disabling press-and-hold for keys in favor of a key repeat"
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use list view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Nlsv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
# sudo pmset -a standbydelay 86400

#"Disable annoying backswipe in Chrome"
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshots location to ~/Desktop"
# defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Setting screenshot format to PNG"
# defaults write com.apple.screencapture type -string "png"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Show all dotfiles
defaults write com.apple.finder AppleShowAllFiles YES

killall Finder

echo "Done!"