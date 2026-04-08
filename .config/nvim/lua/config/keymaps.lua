-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local home = vim.fn.expand("~")

local function create_note(filename, template)
  -- Only create if it doesn't already exist
  if vim.fn.filereadable(filename) == 0 then
    local formatted_date = os.date("%a %d %b %H:%M:%S %Y")

    if vim.fn.filereadable(template) == 1 then
      -- Read template and replace {date} placeholder
      local lines = vim.fn.readfile(template)
      for i, line in ipairs(lines) do
        lines[i] = line:gsub("{date}", formatted_date)
      end
      vim.fn.writefile(lines, filename)
    else
      -- Fallback if no template found
      vim.fn.writefile({
        "# Journal Entry",
        "",
        "Date: " .. formatted_date,
        "",
      }, filename)
    end
  end
end

local function open_todays_note()
  local notes_dir = home .. "/projects/notes/journal"
  local filename = string.format("%s/%s.md", notes_dir, os.date("%Y-%m-%d"))

  -- ensure notes dir exists
  if vim.fn.isdirectory(notes_dir) == 0 then
    vim.fn.mkdir(notes_dir, "p")
  end

  create_note(filename, notes_dir .. "/template")

  vim.cmd.edit(filename)
end

local function open_yesterdays_note()
  local notes_dir = home .. "/projects/notes/journal"
  local yesterday = os.date("%Y-%m-%d", os.time() - 86400)

  local note_path = string.format("%s/%s.md", notes_dir, yesterday)

  note_path = vim.fn.expand(note_path)

  create_note(note_path, notes_dir .. "/template")

  -- Open the note in current window
  vim.cmd("edit " .. vim.fn.fnameescape(note_path))
end

-- Add a description so which-key shows it nicely.
vim.keymap.set("n", "<leader>jn", open_todays_note, { desc = "Open today's note" })
vim.keymap.set("n", "<leader>jy", open_yesterdays_note, { desc = "Open yesterday's note" })

vim.api.nvim_create_user_command("CornellNote", function()
  require("cornell").insert_cornell_note()
end, {})
vim.keymap.set("n", "<leader>jc", "<cmd>CornellNote<CR>", { desc = "Insert Cornell note template" })
