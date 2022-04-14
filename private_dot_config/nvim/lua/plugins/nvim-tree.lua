vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.cmd [[let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }]]

vim.g.nvim_tree_show_icons = {
    folders = 1,
    files = 1,
    git = 1,
    folder_arrows = 1
}

local present, nvimtree = pcall(require, "nvim-tree")

if not present then
    return
end

nvimtree.setup {
    open_on_setup = false,
    open_on_tab = true,
    update_cwd = true,
    view = {
        width = 50
    },
    filters = {
        dotfiles = true,
        custom = {'.git', 'node_modules', '.cache'}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500
    },
    diagnostics = {
        enable = true
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    }
}

vim.cmd([[
  augroup nvim-tree-user
    autocmd!
    autocmd VimEnter * lua require('nvim-tree').toggle(true, true)
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  augroup end
]])