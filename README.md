# Ansible Playbook - WSL Ubuntu Dev Setup

This is an Ansible playbook to setup my [dotfiles](https://gitlab.com/chadjvw/dotfiles).

Sets up and configures all of the software I use for development on in WSL Ubuntu 18.04.1.

If you get an error about 'no dirmngr found' its a know issue: https://github.com/Microsoft/WSL/issues/3286#issuecomment-404282617

Ubuntu needs to carry the fix down from mainstream GPG. In the interim you will have to manually add each ppa with the following command `sudo add-apt-repository ppa:git-core/ppa` then run the playbook.

## What It Does

- Installs packages
- Set up my dotfiles
  - Super-custom git config
  - Sexy fish prompt
  - Lots of useful shortcuts
- Sets up nvim, vim-plug and plugins
- Installs proper fonts

## Quick Installation

1. Install Ansible and git: `sudo apt-get install ansible git`
2. Clone the playbook: `git clone https://gitlab.com/chadjvw/dotfiles.git && cd dotfiles`
3. Run it: `ansible-playbook -i inventory desktop.yml -b -K`
