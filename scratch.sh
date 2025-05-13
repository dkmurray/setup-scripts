# Apps
CASKS=(
    disk-inventory-x
    # google-chrome # should already be installed
    # iterm2 # should already be installed
    logitune
    notion
    raycast
    #rectangle
    scroll-reverser
    spotify
    sublime-text
    suspicious-package
    #visual-studio-code
    vlc
    zoom
    orcaslicer
    the-unarchiver
    logitech-g-hub
    openscad@snapshot
    znotch
)

# Install apps to /Applications
echo "Installing apps with Cask..."
brew tap zkondor/dist
for i in "${CASKS[@]}"; do
    echo "Installing ".$i
    brew install --cask $i
done

brew cleanup

echo "Don't forget to create a cloned iTerm with forced Rosetta before running ./x86.sh"
echo "Next Steps:
- Update Mac settings by running ./settings.sh and restarting
- Set up Sublime, VSCode, and others running mackup restore (again), from ARM iTerm
- Set up VScode settings sync in-app"
