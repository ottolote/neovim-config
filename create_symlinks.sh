#!/bin/bash
#
REPO=`dirs +0`
CONF="~/.config/nvim"

# Create config dir if it doesn't exist
mkdir -p $CONF
echo "Creating symlinks in $CONF"
ln -s $REPO/lua $CONF/lua
ln -s $REPO/init.vim $CONF/init.vim

ls -alh $CONF
