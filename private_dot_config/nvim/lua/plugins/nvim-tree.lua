vim.o.termguicolors = true

vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
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
    open_on_setup = true,
    auto_close = true,
    open_on_tab = true,
    update_cwd = true,
    view = {
        width = 50
    }
}

vim.cmd[[autocmd VimEnter * NvimTreeOpen | wincmd p]]
