 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1d1013',
    base01 = '#2a1c1f',
    base02 = '#352629',
    base03 = '#ab888f',
    base04 = '#e3bdc4',
    base05 = '#f6dce0',
    base06 = '#f6dce0',
    base07 = '#f6dce0',
    base08 = '#ffb4ab',
    base09 = '#ffb1c4',
    base0A = '#deb8f7',
    base0B = '#e1b6ff',
    base0C = '#ffb1c4',
    base0D = '#e1b6ff',
    base0E = '#deb8f7',
    base0F = '#f2daff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f6dce0',          bg = '#1d1013' })
  hi('TelescopeBorder',         { fg = '#ab888f',             bg = '#1d1013' })
  hi('TelescopePromptNormal',   { fg = '#f6dce0',          bg = '#1d1013' })
  hi('TelescopePromptBorder',   { fg = '#ab888f',             bg = '#1d1013' })
  hi('TelescopePromptPrefix',   { fg = '#e1b6ff',             bg = '#1d1013' })
  hi('TelescopePromptCounter',  { fg = '#e3bdc4',  bg = '#1d1013' })
  hi('TelescopePromptTitle',    { fg = '#1d1013',             bg = '#e1b6ff' })
  hi('TelescopePreviewTitle',   { fg = '#1d1013',             bg = '#deb8f7' })
  hi('TelescopeResultsTitle',   { fg = '#1d1013',             bg = '#ffb1c4' })
  hi('TelescopeSelection',      { fg = '#f6dce0',          bg = '#352629' })
  hi('TelescopeSelectionCaret', { fg = '#e1b6ff',             bg = '#352629' })
  hi('TelescopeMatching',       { fg = '#e1b6ff',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
