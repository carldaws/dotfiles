xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git

git config --global user.name "Carl Dawson"
git config --global user.email "carldawson@hey.com"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global init.defaultBranch main

git clone https://github.com/carldaws/dotfiles.git $HOME/dotfiles

cd $HOME/dotfiles
stow .
git remote set-url origin git@github.com:carldaws/dotfiles

cd $HOME
brew bundle
mise install
