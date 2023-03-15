local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "scss",
    "typescript",
    "javascript",
    "java",
    "python",
    "markdown",
    "markdown_inline",
    "rust",
    "toml",
    "json",
    "graphql",
    "yaml",
    "dockerfile",
    "fish",
    "bash",
    "jq",
    "kotlin",
    "ruby",
    "sql",
    "tsx",
    "vue",
    "smithy",
    "ron"
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "typescript-language-server",
    "deno",

    -- rust
    "rust-analyzer",
    "taplo",

    -- Writing
    "alex",
    "proselint",

    -- other
    "shfmt",
    "shellcheck",
    "smithy-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
