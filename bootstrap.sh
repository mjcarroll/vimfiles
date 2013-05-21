#!/usr/bin/env sh

lnif() {
    if [ ! -e $2 ] ; then
ln -s $1 $2
    fi
if [ -L $2 ] ; then
ln -sf $1 $2
    fi
}

endpath=`pwd`

lnif $endpath/.vimrc $HOME/.vimrc
lnif $endpath/.vimrc.bundles $HOME/.vimrc.bundles
lnif $endpath/.vim $HOME/.vim

if [ ! -d $endpath/.vim/bundle ]; then
    mkdir -p $endpath/.vim/bundle
fi

if [ ! -e $HOME/.vim/bundle/vundle ]; then
echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $endpath/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell
