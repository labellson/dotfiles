#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Mis export
export EDITOR=vim
export SUDO_EDITOR=vim

# Variables para xfluxd
export LAT=40.3
export LON=-3.7
