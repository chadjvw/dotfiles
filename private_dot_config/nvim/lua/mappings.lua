local api = vim.api
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true
    }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('', '<up>', '<nop>', {
    noremap = true
})
vim.keymap.set('', '<down>', '<nop>', {
    noremap = true
})
vim.keymap.set('', '<left>', '<nop>', {
    noremap = true
})
vim.keymap.set('', '<right>', '<nop>', {
    noremap = true
})
