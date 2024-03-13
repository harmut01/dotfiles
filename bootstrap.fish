#!/usr/bin/env fish
git pull origin osx
if type -q brew
    brew update
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install tmux ripgrep

    # Install Python dependencies
    curl -sSL https://install.python-poetry.org | python3 -
end

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude ".osx" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "LICENSE-MIT.txt" \
	-avh --no-perms . ~;

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install;
fish install --noninteractive && rm -f install

omf install bobthefish fzf
omf install https://github.com/jhillyerd/plugin-git

# Pre-installed macOS system Vim does not support Python 3.
brew install vim

# Install Vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

brew install cmake python go nodejs
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
