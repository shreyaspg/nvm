#!/usr/bin/sh

NVIM_ENV=~/.config/nvim-env
export NVIM_ENV

rm -rf $NVIM_ENV

mkdir -p $NVIM_ENV/share
mkdir -p $NVIM_ENV/nvim

stow --restow --target=$NVIM_ENV/nvim .

alias nvb='XDG_DATA_HOME=$NVIM_ENV/share XDG_CONFIG_HOME=$NVIM_ENV nvim' 

export nvb
