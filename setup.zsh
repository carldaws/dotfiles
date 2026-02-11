xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git

git config --global user.name "Carl Dawson"
git config --global user.email "carldawson@hey.com"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global init.defaultBranch main

git clone git@github.com:carldaws/dotfiles.git $HOME/dotfiles

brew bundle
cd $HOME/dotfiles && stow .

mise install
