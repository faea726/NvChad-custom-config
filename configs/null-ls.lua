local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- python
  b.diagnostics.ruff,
  b.formatting.isort,
  b.formatting.black,

  -- go
  b.diagnostics.golangci_lint,
  b.formatting.gofumpt,

  -- rust
  b.formatting.rustfmt,

  -- solidity
  b.diagnostics.solhint,

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "solidity" } },
  b.diagnostics.markdownlint,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
}

-- format on save
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params {}, function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd "silent noautocmd update"
      end)
    end
  end)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          async_formatting(bufnr)
        end,
      })
    end
  end,
}
