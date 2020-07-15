#!/usr/bin/env just --justfile

dotfiles:
    ansible-playbook -i inventory desktop.yml -b -K --tags "dotfiles"

# vim: set ft=make :
