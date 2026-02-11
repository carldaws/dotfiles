mkdir -p $HOME/Code && cd $HOME/Code

git clone https://github.com/neovim/neovim

cd $HOME/Code/neovim

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
