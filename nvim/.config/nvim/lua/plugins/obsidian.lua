return({
  "epwalsh/obsidian.nvim",
  tag = "*",  -- recommended, use latest release instead of latest commit
  requires = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    require("obsidian").setup({
      ui = { enable = false},
      workspaces = {
        {
          name = "nDIFFrnt",
          path = "~/Documents/nDIFFrnt/",
        },
        {
          name = "chat-vault",
          path = "~/Documents/chat-vault",
        },
      },
    })
  end,
})
