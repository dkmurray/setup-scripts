echo "Creating an SSH key for you..."
ssh-keygen -t ed25519 -C "skivt10@gmail.com"

echo "Please add this public key (SHA256) to github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this is complete..."

echo "Installing xcode-stuff..."
xcode-select --install

echo "Installing Rosetta2..."
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing ARM homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Setting git config..."

git config --global user.name "David Murray"
git config --global user.email skivt10@gmail.com

echo "Installing brew git utilities..."
brew install git-extras

echo "Installing other brew stuff..."
brew tap jakehilborn/jakehilborn
PROGS=(
    bat
    displayplacer
    gh
    mackup
    podman
    tmux
    trash
    tree
    wget
)

for i in "${PROGS[@]}"; do
  echo "Installing " $i "..."
  brew install $i
done

echo "Installing Fonts..."
brew tap epk/epk
brew install font-sf-mono-nerd-font

echo "Installing MesloLGS NF..."
wget -P ~/Library/Fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -P ~/Library/Fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -P ~/Library/Fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -P ~/Library/Fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing up powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Run 'p10k configure' if you're not restoring from Mackup later"
echo ""

echo "Setting up Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing Dropbox..."
brew install --cask dropbox

echo "Please login to and sync Dropbox with your work account and then come back to this script."
read -p "Press [Enter] key after this..."

echo "Setting up Mackup..." # Defaults to dropbox so no need to change
read -p "Would you like to restore from mackup?" yn
    case $yn in
        [Yy]* ) mackup restore; break;;
        [Nn]* ) echo "Please add arch flags from 'https://6sense.atlassian.net/wiki/spaces/ENG/pages/2424504461/Guide+for+M1+based+Big+Sur+MacBook+devices' to your .zshrc if they are not already there"; break;;
        * ) echo "Please answer yes or no.";;
    esac

echo "Starting ssh-agent and adding keys (ensure your ~/.ssh/config has been set up or restored from mackup)"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_ed25519

echo "Cleaning up brew..."
brew cleanup

echo "Please restart ZSH with 'exec zsh' and run './apps.sh'"
