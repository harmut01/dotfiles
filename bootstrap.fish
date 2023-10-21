#!/usr/bin/env fish
git pull origin main

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude ".osx" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "LICENSE-MIT.txt" \
	-avh --no-perms . ~;

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install;
fish install --noninteractive
rm -f install

brew update

omf install bobthefish fzf 
omf install https://github.com/jhillyerd/plugin-git
