#!/usr/bin/env bash

echo 'Updating Neovim plugins...'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
