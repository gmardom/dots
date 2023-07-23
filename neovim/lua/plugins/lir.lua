return {
  "tamago324/lir.nvim",
  pin = true, commit = "969e95bd07ec315b5efc53af69c881278c2b74fa",

  opts = function()
    local actions = require("lir.actions")
    local clipboard = require("lir.clipboard.actions")

    return {
      show_hidden_files = true,
      devicons = { enable = false },
      mappings = {
        ["q"] = actions.quit,
        ["l"] = actions.edit,
        ["h"] = actions.up,

        ["@"] = actions.cd,
        ["."] = actions.toggle_show_hidden,

        ["M"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["Y"] = actions.yank_path,
        ["R"] = actions.rename,
        ["D"] = actions.delete,

        ["y"] = clipboard.copy,
        ["d"] = clipboard.cut,
        ["p"] = clipboard.paste,
      },
    }
  end,
  config = function (_, opts)
    require("lir").setup(opts)

    vim.api.nvim_create_autocmd({"FileType"}, {
      pattern = {"lir"},
      callback = function()
        -- Print current directory
        vim.api.nvim_echo({{vim.fn.expand("%:p"), "Normal"}}, false, {})
      end
    })

    vim.api.nvim_create_user_command("Lir", function(opt)
      local path = table.unpack(opt.fargs) or "."
      vim.cmd("edit " .. path)
    end, { nargs = "*", complete = "dir" })
  end
}
