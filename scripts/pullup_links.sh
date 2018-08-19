#!/bin/bash

# This script must be idempotent

# Note:
# - .vimrc is linked by pullup_vim.sh
# - nvim/init.vim is linked by pullup_nvim.sh
# - gitconfig is linked by install_git_ssh.sh

ln -svf ~/dotfiles/ackrc ~/.ackrc
ln -svf ~/dotfiles/ideavimrc ~/.ideavimrc
ln -svf ~/dotfiles/flake8 ~/.config/flake8
ln -svf ~/dotfiles/isort.cfg ~/.isort.cfg
ln -svf ~/dotfiles/gitignore_global ~/.gitignore_global
ln -svf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -svf ~/dotfiles/tigrc ~/.tigrc

