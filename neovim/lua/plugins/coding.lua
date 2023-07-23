return {
  {
    -- Spec ----------------------------------------------------------------------
    "L3MON4D3/LuaSnip",
    pin = true, tag = "v1.2.1",
    dependencies = {
      "rafamadriz/friendly-snippets",
      pin = true, commit = "6e0afe3be0ba43ef03d495a529de8fb22721c0d0",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    -- Conf ----------------------------------------------------------------------
    build = (not jit.os:find("Windows"))
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  {
    -- Spec ----------------------------------------------------------------------
    "hrsh7th/nvim-cmp",
    pin = true, commit = "c4e491a87eeacf0408902c32f031d802c7eafce8",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        pin = true, commit = "44b16d11215dce86f253ce0c30949813c0a90765"
      },
      {
        "hrsh7th/cmp-buffer",
        pin = true, commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa"
      },
      {
        "hrsh7th/cmp-path",
        pin = true, commit = "91ff86cd9c29299a64f968ebb45846c485725f23"
      },
      {
        "saadparwaiz1/cmp_luasnip",
        pin = true, commit = "18095520391186d634a0045dacaa346291096566"
      },
    },

    -- Lazy ----------------------------------------------------------------------
    event = "InsertEnter",

    -- Conf ----------------------------------------------------------------------
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            -- local icons = require("lazyvim.config").icons.kinds
            -- if icons[item.kind] then
            --   item.kind = icons[item.kind] .. item.kind
            -- end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },

  {
    "echasnovski/mini.pairs",
    pin = true, tag = "v0.9.0",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.comment",
    pin = true, tag = "v0.9.0",
    event = "VeryLazy",
    opts = {},
  },
}
