-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Turn on relateve line number
-- vim.wo.relativenumber = true

-- Neovide configuration
if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h11"

  vim.g.neovide_padding_top = 5
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5

  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_vfx_mode = "wireframe"

  vim.g.neovide_hide_mouse_when_typing = true
end
