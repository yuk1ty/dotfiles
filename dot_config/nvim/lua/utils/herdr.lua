-- Integration helpers for herdr (https://herdr.dev), an agent-oriented
-- terminal multiplexer. Each herdr pane exports HERDR_* environment variables,
-- which Neovim inherits, so we can locate ourselves without relying on focus.

local M = {}

--- Run a herdr CLI command synchronously and return its parsed JSON result.
---@param args string[] arguments after the `herdr` binary
---@return table|nil decoded, string|nil err
local function herdr_json(args)
  local cmd = { "herdr" }
  vim.list_extend(cmd, args)

  local res = vim.system(cmd, { text = true }):wait()
  if res.code ~= 0 then
    return nil, ("`herdr %s` failed: %s"):format(table.concat(args, " "), vim.trim(res.stderr or ""))
  end

  local ok, decoded = pcall(vim.json.decode, res.stdout)
  if not ok or type(decoded) ~= "table" then return nil, "failed to parse herdr JSON output" end
  return decoded, nil
end

--- Convert an absolute file path into a path relative to `root`, when the file
--- lives under it. Falls back to the original absolute path otherwise.
---@param file string absolute file path
---@param root string|nil agent root (cwd)
---@return string
local function relativize(file, root)
  if not root or root == "" then return file end
  local prefix = root:gsub("/+$", "") .. "/"
  if file:sub(1, #prefix) == prefix then return file:sub(#prefix + 1) end
  return file
end

--- Resolve the current file and the first coding agent in this herdr tab.
--- Notifies and returns nil on any failure (not in herdr, no file, no agent…).
---@return table|nil target_pane, string|nil abs_file
local function resolve_target()
  if vim.env.HERDR_ENV ~= "1" then
    vim.notify("herdr: not running inside a herdr pane (HERDR_ENV != 1)", vim.log.levels.WARN)
    return nil
  end

  local file = vim.fn.expand "%:p"
  if file == nil or file == "" then
    vim.notify("herdr: current buffer is not backed by a file", vim.log.levels.WARN)
    return nil
  end

  local tab_id = vim.env.HERDR_TAB_ID
  if tab_id == nil or tab_id == "" then
    vim.notify("herdr: HERDR_TAB_ID is not set", vim.log.levels.ERROR)
    return nil
  end
  local self_pane = vim.env.HERDR_PANE_ID

  local list, err = herdr_json { "pane", "list" }
  if not list then
    vim.notify("herdr: " .. err, vim.log.levels.ERROR)
    return nil
  end

  local panes = (list.result or {}).panes or {}
  -- The first pane in list order that is a coding agent (has an `agent`
  -- field), lives in our tab, and is not ourselves.
  for _, pane in ipairs(panes) do
    if pane.tab_id == tab_id and pane.agent ~= nil and pane.pane_id ~= self_pane then return pane, file end
  end

  vim.notify("herdr: no coding agent found in the current tab", vim.log.levels.WARN)
  return nil
end

--- Build the `@path` payload (optionally with a `#L<start>-<end>` line range)
--- and insert it into the target agent's prompt without submitting (no Enter).
---@param range integer[]|nil two line numbers; order-independent
local function send_path(range)
  local target, file = resolve_target()
  if not target then return end

  local payload = "@" .. relativize(file, target.cwd)
  if range then
    local s, e = range[1], range[2]
    if s > e then
      s, e = e, s
    end
    payload = payload .. "#L" .. s
    if e ~= s then payload = payload .. "-" .. e end
  end

  -- Append a trailing newline so the path sits on its own line in the agent's
  -- prompt. This is a literal LF in the inserted text, not an Enter key press,
  -- so it does not submit the prompt.
  local res = vim.system({ "herdr", "pane", "send-text", target.pane_id, payload .. "\n" }, { text = true }):wait()
  if res.code ~= 0 then
    vim.notify("herdr: send-text failed: " .. vim.trim(res.stderr or ""), vim.log.levels.ERROR)
    return
  end

  vim.notify(("herdr: sent %s to %s (%s)"):format(payload, target.agent, target.pane_id), vim.log.levels.INFO)
end

--- Send the current buffer's file path to the first coding agent in this tab.
function M.send_file_to_agent() send_path(nil) end

--- Send the current buffer's file path plus the selected line range, e.g.
--- `@lua/utils/herdr.lua#L10-22`. Intended for visual-mode mappings; reads the
--- current selection via the `v` mark and cursor position, which are valid
--- *while still in visual mode*, unlike `'<`/`'>` which are not updated until
--- visual mode is exited (and return 0 on a fresh buffer).
function M.send_selection_to_agent() send_path { vim.fn.line "v", vim.fn.line "." } end

--- Send the current buffer's file path plus the current cursor line,
--- e.g. `@lua/utils/herdr.lua#L42`. Intended for normal-mode use when no
--- selection has been made.
function M.send_line_to_agent() send_path { vim.fn.line ".", vim.fn.line "." } end

return M
