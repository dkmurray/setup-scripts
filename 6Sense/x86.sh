echo "Installing x86 homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing x86 Rsync"
rm /usr/local/bin/rsync
brew install rsync
# ln -s /usr/local/Homebrew/opt/rsync/bin/rsync /usr/local/bin/rsync

echo "Installing & linking x86 Python3.7"
brew install python@3.7
ln -s /usr/local/opt/python@3.7/bin/python3.7 /usr/local/bin/python3.7
ln -s /usr/local/opt/python@3.7/bin/pip3.7 /usr/local/bin/pip3.7
ln -s /usr/local/opt/python@3.7/bin/python3.7-config /usr/local/bin/python3.7-config
