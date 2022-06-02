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
        highlight_git = true,
        highlight_opened_files = "icon",
        indent_markers = {
            enable = true
        }
    }
}

local nvim_tree_group = vim.api.nvim_create_augroup('nvim-tree-user', {
    clear = true
})

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        require('nvim-tree').toggle(true, true)
    end,
    group = nvim_tree_group,
    pattern = '*'
})

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd "quit"
        end
    end
})
