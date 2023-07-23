return {
  "Mofiqul/vscode.nvim",
  pin = true, commit = "05973862f95f85dd0564338a03baf61b56e1823f",
  opts = {
    transparent = false,
    italic_comments = false,
  },
  config = function(_, opts)
    vim.o.background = "dark"
    require("vscode").setup(opts)
    require("vscode").load()
  end,
}
