echo "Installing x86 homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing & linking x86 Python3.7"
brew install python@3.7
ln -s /usr/local/Homebrew/opt/python@3.7/bin/python3.7 /usr/local/bin/python3.7
ln -s /usr/local/Homebrew/opt/python@3.7/bin/pip3.7 /usr/local/bin/pip3.7
ln -s /usr/local/Homebrew/opt/python@3.7/bin/python3.7-config /usr/local/bin/python3.7-config

echo "Please download and install the latest java 8 and java 11 JDKs from Adoptium (https://6sense.atlassian.net/wiki/spaces/ENG/pages/2424504461/Guide+for+M1+based+Big+Sur+MacBook+devices)"

echo "Installing libmemcached"
brew install libmemcached

echo "Installing Maven"
brew install maven
echo "Please set up mavenrc in a new tab (https://6sense.atlassian.net/wiki/spaces/ENG/pages/2424504461/Guide+for+M1+based+Big+Sur+MacBook+devices)"
read -p "Press [Enter] key after this is complete..."

echo "Creating ~/bin"
sudo mkdir ~/bin

echo "Setting up Bazel"
wget -P ~/bin -O bazel https://github.com/bazelbuild/bazel/releases/download/3.3.0/bazel-3.3.0-darwin-x86_64
chmod u+x ~/bin/bazel

echo "Installing & linking x86 rsync"
brew install rsync
ln -s /usr/local/Homebrew/opt/rsync/bin/rsync /usr/local/bin/rsync

echo "Installing various other tools & dependencies"
PROGS=(
    coreutils
    gh
    gpg
    graphviz
    sqlite3
    tmux
    tree
    wget
)

for i in "${PROGS[@]}"; do
  echo "Installing " $i "..."
  brew install $i
done

echo "Installing & linking MySQL"
brew install mysql@5.7
brew install mysql-client@5.7
ln -s /usr/local/Homebrew/opt/mysql@5.7/bin/mysql_config /usr/local/bin/mysql_config

echo "Setting up Redis"
brew install redis
brew services start redis