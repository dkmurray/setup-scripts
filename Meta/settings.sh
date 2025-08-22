#!/bin/bash
echo "Applying macOS customization settings..."

# Set key repeat speed
defaults write -g InitialKeyRepeat -int 25
defaults write -g KeyRepeat -int 2

# Expand Save and Print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Auto-quit printer app once jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Enable full keyboard access (Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Show external drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Set Finder to list view by default
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Avoid .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable snap-to-grid for icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Speed up Mission Control animation and group windows by app
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool true

# Dock auto-hide with no delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Copy plain email addresses in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Terminal: Use UTF-8 and Pro theme
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

# Prevent Time Machine from prompting for new disks
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Don’t auto-rearrange Spaces
defaults write com.apple.dock mru-spaces -bool false

# Show hidden files (dotfiles)
defaults write com.apple.finder AppleShowAllFiles YES

# Restart affected apps
killall Finder
killall Dock

echo "All settings applied. Please log out and log back in to finalize changes."