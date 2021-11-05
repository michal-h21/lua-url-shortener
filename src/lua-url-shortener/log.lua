local M = {}

function M.error(msg)
  print("[Error] " .. msg)
end

function M.warning(msg)
  print("[Warning] " .. msg)
end

function M.info(msg)
  print("[Info] " .. msg)
end

return M
