# Ansible Playbook - Ubuntu Dev Setup

This is an [Ansible](https://www.ansible.com/) playbook to setup my [dotfiles](https://github.com/chadjvw/dotfiles) and development environment.

Sets up and configures all of the software I use for development on Ubuntu 18.10.

## What It Does

- Installs cli packages
- Set up dotfiles
  - Super-custom git config
  - Sexy fish prompt
  - Lots of useful shortcuts
- Sets up nvim, vim-plug and plugins
- Installs proper fonts
- Installs window mangers, terminal, bars, etc

## Quick Installation

1. Install Ansible and git: `sudo apt-get install ansible git`
2. Clone the playbook: `git clone https://github.com/chadjvw/dotfiles.git && cd dotfiles`
3. Run it: `ansible-playbook -i inventory desktop.yml -b -K`

### Run specific tasks

Redeploy dotfiles only: `ansible-playbook -i inventory desktop.yml -b -K --tags "dotfiles"`
Redeploy dotfiles and GUI: `ansible-playbook -i inventory desktop.yml -b -K --tags "dotfiles,gui"`