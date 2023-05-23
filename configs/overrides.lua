local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",

    "python",
    "solidity",

    "go",

    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",

    "ini",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- python
    "pyright",
    "ruff",
    "black",
    "isort",

    -- go
    "gopls",
    "gofumpt",
    "staticcheck",

    -- solidity
    "nomicfoundation-solidity-language-server",
    "solhint",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "markdownlint",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
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
