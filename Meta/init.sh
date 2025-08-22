# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing ARM homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing other brew stuff..."
PROGS=(
    bat
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing up powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
echo "Change theme to powerlevel10k/powerlevel10k and run 'exec zsh' after this script"
echo ""

echo "Setting up Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


echo "Cleaning up brew..."
brew cleanup

echo "Please restart ZSH with 'exec zsh' and run './apps.sh'"
