-- TODO: Replace with vim.keymap
return function(args)
  local lhs = args[1]
  local rhs = args[2]
  local opts = {
    mode = "n",
    silent = true,
    noremap = true,
  }
  for k, v in pairs(args) do
    if type(k) ~= "number" then
      opts[k] = v
    end
  end
  local modes = opts.mode
  if type(modes) == "string" then
    modes = { modes }
  end
  opts.mode = nil
  if type(rhs) == "function" then
    opts["callback"] = rhs
    rhs = "<Nop>"
  end
  for _, mode in pairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end
