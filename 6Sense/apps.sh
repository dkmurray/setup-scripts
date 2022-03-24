# Apps
CASKS=(
    alfred
    balance-lock
    dbeaver-community
    deluge
    disk-inventory-x
    google-chrome # should already be installed
    insomnia
    iterm2 # should already be installed
    notion
    pritunl
    rectangle
    scroll-reverser
    spotify
    steermouse
    sublime-text
    suspicious-package
    visual-studio-code
    vlc
    zoom
)

# Install apps to /Applications
echo "Installing apps with Cask..."
brew tap homebrew/cask
for i in "${CASKS[@]}"; do
    echo "Installing ".$i
    brew install --cask $i
done

brew cleanup

echo "Don't forget to clone iTerm and force to use Rosetta before running x86.sh"
echo "Next Steps:
- update Macs settings by running ./settings.sh and restarting
- setup sublime, VSCode, and others using mackup restore (again)
- set up vscode settings sync in-app"
