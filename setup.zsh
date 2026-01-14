xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git

git config --global user.name "Carl Dawson"
git config --global user.email "carldawson@hey.com"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore"
git config --global init.defaultBranch main

git clone --bare https://github.com/carldaws/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

brew bundle

mise install
