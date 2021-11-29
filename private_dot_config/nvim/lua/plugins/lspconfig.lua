local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "nvim-lsp-installer")
local present3, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not (present1 or present2) then
   return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if present3 then
    capabilities = cmp_lsp.update_capabilities(capabilities)
 end

lspinstall.on_server_ready(function(server)
    local opts = {
        capabilities = capabilities,
    }

    server:setup(opts)
end)