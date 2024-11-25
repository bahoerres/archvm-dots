return {
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require("iron.core")
      iron.setup({
        config = {
          -- These are the default values
          repl_open_cmd = "vertical botright 80 split",
          repl_definition = {
            python = {
              command = { "python" }
            },
          },
        },
        keymaps = {
          send_line = "<leader>sl",
          send_file = "<leader>sf",
          send_until_cursor = "<leader>su",
          send_mark = "<leader>sm",
          mark_motion = "<leader>mc",
          mark_visual = "<leader>mc",
          remove_mark = "<leader>md",
          cr = "<leader>s<cr>",
          interrupt = "<leader>s<space>",
          exit = "<leader>sq",
          clear = "<leader>cl",
        },
      })
    end,
  },
}

