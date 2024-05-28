vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    vim.opt_local.formatoptions = "jnqlro"
    vim.opt_local.comments:remove("fb:-")
    vim.opt_local.comments:append(":-")
  end,
  desc = "Set formatoptions to jnqlro and continue list on new line",
})

local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = "Note Template"
  local obsidian = require("obsidian").get_client()

  local title = vim.fn.input({
    default = vim.api.nvim_get_current_line():match("%[%[(.-)]]"),
    prompt = "title: ",
  })

  local note = obsidian:create_note({ title = title, no_write = true })

  if not note then
    return
  end
  -- Open new note in a buffer
  obsidian:open_note(note, { sync = true })
  -- Write to buffer
  obsidian:write_note_to_buffer(note, { template = TEMPLATE_FILENAME })
  -- HACK: Delete empty lines before frontmatter (template is injected at line 2)
  vim.api.nvim_buf_set_lines(0, -2, -1, false, {})
end

vim.keymap.set(
  "n",
  "<leader>oo",
  ":ObsidianOpen<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Open this file in obsidian" }
)
vim.keymap.set(
  "n",
  "<leader>os",
  ":ObsidianFollowLink hsplit<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Open link in horizontal split" }
)
vim.keymap.set(
  "n",
  "<leader>ov",
  ":ObsidianFollowLink vsplit<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Open link in vertical split" }
)
vim.keymap.set(
  "n",
  "<leader>ob",
  ":ObsidianBacklinks<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Show files that links to this file" }
)
vim.keymap.set(
  "n",
  "<leader>on",
  createNoteWithDefaultTemplate,
  { buffer = true, desc = "[obsidian] Create note with template" }
)
vim.keymap.set(
  "v",
  "<leader>oe",
  ":ObsidianExtractNote<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Extract selected to new note" }
)
vim.keymap.set(
  "n",
  "<leader>ot",
  "<Esc>:ObsidianTemplate<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Insert a template" }
)
vim.keymap.set("n", "<leader>oi", function()
  local file_name = "pasted-image--" .. os.date("%Y-%m-%d--%H-%M-%S")
  return "<Esc>:ObsidianPasteImg " .. file_name .. "<CR>"
end, { expr = true, buffer = true, desc = "[obsidian] Paste image from clipboard" })

vim.keymap.set(
  "n",
  "<C-n>",
  createNoteWithDefaultTemplate,
  { buffer = true, desc = "[obsidian] Create note with template" }
)
vim.keymap.set(
  "v",
  "<C-e>",
  ":ObsidianExtractNote<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[obsidian] Extract selected to new note" }
)
vim.keymap.set("i", "<C-t>", "<Esc>:ObsidianTemplate<CR>", { noremap = true, silent = true, buffer = true })
vim.keymap.set("i", "<C-.>", function()
  local file_name = "pasted-image--" .. os.date("%Y-%m-%d--%H-%M-%S")
  return "<Esc>:ObsidianPasteImg " .. file_name .. "<CR>"
end, { expr = true, buffer = true, desc = "[obsidian] Paste image from clipboard" })

vim.opt_local.conceallevel = 1 -- needed for obsidian.nvim
