local M = {}

---Insert a Cornell Notes markdown template at the cursor.
---Prompts for a title (defaults to current file name without extension).
function M.insert_cornell_note()
  -- Default title = current file name (without extension), or empty if none
  local bufname = vim.api.nvim_buf_get_name(0)
  local default_title = ""
  if bufname ~= "" then
    default_title = vim.fn.fnamemodify(bufname, ":t:r")
  end

  local title = vim.fn.input({ prompt = "Cornell note title: ", default = default_title })
  if title == nil or title == "" then
    title = default_title ~= "" and default_title or "Title"
  end

  local lines = {
    "# " .. title,
    "",
    "## Cues",
    "",
    "## Notes",
    "",
    "## Summary",
    "",
  }

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- row is 1-indexed; insert before `row` to place template at cursor line
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)

  -- Move cursor to first empty line under "## Cues"
  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end

return M
