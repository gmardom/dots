return {
  {
    "nvim-treesitter/nvim-treesitter",
    pin = true, tag = "v0.9.0",

    build = function()
      require("nvim-treesitter.install").update({
        with_sync = true
      })
    end,

    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "comment",
          "lua",
          "c", "cpp",
          "c_sharp",
          "rust"
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "NMAC427/guess-indent.nvim",
    pin = true, commit = "b8ae749fce17aa4c267eec80a6984130b94f80b2",
    opts = {
      auto_cmd = true,
      override_editorconfig = false,
      filetype_exclude = {
        "netrw", "tutor", "lir"
      },
      buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
    },
  }
}
