return {
  -- Spec ----------------------------------------------------------------------
  "williamboman/mason.nvim",
  pin = true, tag = "v1.6.0",

  -- Lazy ----------------------------------------------------------------------
  cmd = "Mason",
  keys = {
    { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
  },

  -- Conf ----------------------------------------------------------------------
  opts = {
    ensure_installed = {
      "clangd", "lua-language-server"
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)

    local registry = require("mason-registry")

    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end

    if registry.refresh then
      registry.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
