local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")
local present3, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not (present1 or present2) then
   return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if present3 then
    capabilities = cmp_lsp.update_capabilities(capabilities)
 end

local function setup_servers()
    lspinstall.setup()

    local servers = lspinstall.installed_servers()

    for _, server in pairs(servers) do
        lspconfig[server].setup {
            capabilities = capabilities
        }
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
