return {
  -- Spec ----------------------------------------------------------------------
  "neovim/nvim-lspconfig",
  pin = true, commit = "deade69789089c3da15237697156334fb3e943f0",
  dependencies = {
    "cmp-nvim-lsp",
    "mason.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      pin = true, tag = "v1.11.0",
    },
  },

  -- Lazy ----------------------------------------------------------------------
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LspInfo" }
  },

  -- Conf ----------------------------------------------------------------------
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = ""
      },
    },

    inlay_hints = { enabled = true },

    autoformat = false,

    servers = {
      clangd = {},
      lua_ls = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }
  },
  config = function(_, opts)
    local servers = opts.servers

    local function on_attach(_, bufnr)
      local nmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
      nmap("<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
      nmap("gd", "<cmd>Telescope lsp_definitions<cr>", "Goto Definition")
      nmap("gr", "<cmd>Telescope lsp_references<cr>", "References")
      nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
      nmap("gI", "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation")
      nmap("gy", "<cmd>Telescope lsp_type_definitions<cr>", "Goto T[y]pe Definition")
      nmap("K", vim.lsp.buf.hover, "Hover")
      nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
      nmap("<c-k>", vim.lsp.buf.signature_help,"Signature Help")
      nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local mason_lsp = require("mason-lspconfig")

    local ensure_installed = {}
    for server, server_opts in pairs(servers) do
		  if server == "lua_ls" then
      elseif server_opts then
        server_opts = server_opts == true and {} or server_opts
        ensure_installed[#ensure_installed + 1] = server
      end
    end

    mason_lsp.setup({ ensure_installed = ensure_installed })
    mason_lsp.setup_handlers({function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end})
  end,
}
