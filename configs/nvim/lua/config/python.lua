local venv = os.getenv("VIRTUAL_ENV")
if venv then
  local handle = io.popen("pyenv which python3")
  local result = handle:read("*a"):gsub("\n", "")
  handle:close()
  vim.g.molten_python_executable = result
  vim.g.python3_host_prog = result
end
