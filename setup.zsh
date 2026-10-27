xcode-select --install

git config --global user.name "Carl Dawson"
git config --global user.email "carldawson@hey.com"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global init.defaultBranch main

git clone https://github.com/carldaws/dotfiles.git $HOME/dotfiles

cd $HOME/dotfiles
git remote set-url origin git@github.com:carldaws/dotfiles.git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

mkdir -p $HOME/.config/zsh
stow common mac
brew bundle --global

exec zsh
