---@type MappingsTable
local M = {}

function OpenURL()
  local url = vim.fn.expand "<cfile>"

  if url:sub(1, 4) ~= "http" then
    -- Display notification if text is not a link
    vim.notify("'" .. url .. "' is not a link", 1, { title = "Neovim" })
    return
  end

  local command = ""
  if vim.fn.has "win32" == 1 then
    command = "start"
  elseif vim.fn.has "mac" == 1 then
    command = "open"
  elseif vim.fn.has "unix" == 1 then
    command = "xdg-open"
  end
  vim.fn.system(command .. " " .. url)
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["gx"] = { ":lua OpenURL()<CR>", "open link" },
  },
}

-- more keybinds!

return M
