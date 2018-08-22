#!/bin/bash

set -euxo pipefail

if which brew; then

    brew install zsh \
        mozjpeg \
        jpegoptim \
        exiftool \
        imagemagic

    brew install fzf
    $(brew --prefix)/opt/fzf/install

    sudo sh -c "echo `which zsh` >> /etc/shells"
    chsh -s `which zsh`

elif which dnf; then

    sudo dnf install zsh \
        libjpeg-turbo-utils \
        jpegoptim \
        perl-Image-ExifTool \
        ImageMagick

    sudo dnf install fzf
    # TODO (?) is installation required?

    sudo usermod -s `which zsh` `whoami`
elif which apt; then

    sudo apt install zsh \
        libjpeg-turbo-progs \
        jpegoptim \
        libimage-exiftool-perl \
        imagemagick

    # https://github.com/junegunn/fzf#using-git
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    sudo usermod -s `which zsh` `whoami`
else
    echo "Unsupported OS"
    exit 1
fi

# https://github.com/robbyrussell/oh-my-zsh#basic-installation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# Make .zshrc look like this:
# source ~/dotfiles/zshrc/ohmyzsh
# source $ZSH/oh-my-zsh.sh
# source ~/dotfiles/zshrc/zshrc

perl -i -p0e \
    's#(source \$ZSH/oh-my-zsh.sh)#source ~/dotfiles/zshrc/ohmyzsh\n${1}\nsource ~/dotfiles/zshrc/zshrc#igs' \
    ~/.zshrc
