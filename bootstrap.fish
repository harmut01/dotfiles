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

# Save Homebrew’s installed location.
brew upgrade
set -u BREW_PREFIX (brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "$BREW_PREFIX/bin/gsha256sum" "$BREW_PREFIX/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# # Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Pre-installed macOS system Vim does not support Python 3.
brew install vim

brew install cmake python go nodejs

# Install Vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
