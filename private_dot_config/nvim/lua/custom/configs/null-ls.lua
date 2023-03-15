local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier,
  b.diagnostics.jsonlint,

  -- Lua
  b.formatting.stylua,

  -- Writing
  b.code_actions.proselint,
  b.diagnostics.proselint,
  b.diagnostics.alex,

  -- Shell
  b.code_actions.shellcheck,
  b.diagnostics.shellcheck,
  b.formatting.shfmt,
  b.diagnostics.fish,
  b.formatting.fish_indent,
  b.formatting.jq,
  b.formatting.just,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
