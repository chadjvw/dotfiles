local present, ts_config = pcall(require, 'nvim-treesitter.configs')

if not present then
    return
end

ts_config.setup({
    ensure_installed = 'all',
    highlight = {
        enable = true,
        disable = {}
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
        highlight_current_scope = {
            enable = true
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr"
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>"
            }
        }
    }
})
