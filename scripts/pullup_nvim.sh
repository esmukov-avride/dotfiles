#!/bin/bash

set -euxo pipefail

if which brew; then
    brew tap neovim/neovim
    packages="
        clang-format
        ctags-exuberant
        fzf
        gcc
        go
        gopls
        llvm
        neovim
        npm
        pgformatter
        postgresql@14
        ruby@2.7
        shellcheck
        staticcheck
        the_silver_searcher
        wget
    "
    brew install $packages || brew upgrade $packages

else
    sudo -E apt install \
        neovim \
        shellcheck \
        silversearcher-ag \
        wget \
    ;
fi

# zsh correctly initializes pyenv
zsh -ls < /dev/null << 'EOF' || true
source ~/.zshrc

pyenv shell system
python3 -m pip install --break-system-packages --user --upgrade \
    black \
    coverage \
    flake8 \
    flake8-isort \
    isort \
    mypy \
    pip-tools \
    pipenv \
    py-spy \
    pylint \
    pyls-isort \
    pylsp-mypy \
    python-lsp-black \
    python-lsp-ruff \
    python-lsp-server'[all]' \
    pyupgrade \
    ruff \
    tox \
    tox-pyenv \
    tox-venv \
    twine \
;

pyenv shell `pyenv versions | egrep -o '3\.8[.0-9]+' | tail -1`
pyenv virtualenv-delete -f neovim_py3
pyenv virtualenv neovim_py3
pyenv shell neovim_py3
pip install --upgrade neovim

EOF


rm -Rf ~/.config/nvim/
mkdir -p ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

if which brew; then
    mkdir -p ~/Library/Fonts/
    pushd $_
fi

if [ ! -r "CousineNerdFont-Regular.ttf" ]; then
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Regular/CousineNerdFont-Regular.ttf
    if which brew; then
        echo "Change the font manually in the iTerm2 settings to 'Cousine'."
    fi
fi
popd


ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
