#!/usr/bin/env bash

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude ".osx" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "LICENSE-MIT.txt" \
	-avh --no-perms . ~;

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && \
        fish -c 'fisher install jorgebucaran/fisher curl'

fish -c 'fisher install jhillyerd/plugin-git'
