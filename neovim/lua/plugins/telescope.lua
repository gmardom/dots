return {
  "nvim-telescope/telescope.nvim",
  pin = true, tag = "0.1.2",
  dependencies = {{
    "nvim-lua/plenary.nvim",
    pin = true, tag = "v0.1.3",
  }},

  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  },
}
