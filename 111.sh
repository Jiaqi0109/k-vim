#!/bin/bash

# refer  spf13-vim bootstrap.sh`
BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

FOR_VIM=true
FOR_NEOVIM=false
if [ "$1" != "" ]; then
    case $1 in
        --for-vim)
            FOR_VIM=true
            FOR_NEOVIM=false
            shift
            ;;
        --for-neovim)
            FOR_NEOVIM=true
            FOR_VIM=false
            shift
            ;;
        --for-all)
            FOR_VIM=true
            FOR_NEOVIM=true
            shift
            ;;
        *)
            show_help
            exit
            ;;
    esac
fi

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}



echo "Step2: setting up symlinks"
if $FOR_VIM; then
    lnif $CURRENT_DIR/vimrc $HOME/.vimrc
    lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
    lnif "$CURRENT_DIR/" "$HOME/.vim"
fi
if $FOR_NEOVIM; then
    lnif "$CURRENT_DIR/" "$HOME/.config/nvim"
    lnif $CURRENT_DIR/vimrc $CURRENT_DIR/init.vim
fi


echo "Install Done!"
