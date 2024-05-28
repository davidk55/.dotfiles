return {
  "nvim-lualine/lualine.nvim",

  config = function()
    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @" .. recording_register
      end
    end
    local lint_progress = function()
      local linters = require("lint").get_running()
      if #linters == 0 then
        return "󰦕"
      end
      return "󱉶 " .. table.concat(linters, ", ")
    end

    -- =============== SETUP ===============
    require("lualine").setup({
      options = {
        theme = "gruvbox",
        disabled_filetypes = {
          "NvimTree",
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
          "branch",
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filename", path = 1 },
          "searchcount",
          "selectioncount",
          { "lint-progress", fmt = lint_progress },
        },
        lualine_x = { "encoding", "filesize", "filetype", "fileformat" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })

    -- =============== AUTOCOMMANDS ===============
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh({
          place = { "statusline" },
        })
      end,
      desc = "Show recording in the status line",
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.uv.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            require("lualine").refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
      desc = "Make sure that recording status is removed when the recording ends",
    })
  end,
}
