local api = vim.api
local cmd = vim.cmd

metals_config = require'metals'.bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "pekko.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl" ,
    "com.github.swagger.pekko.javadsl" 
  },
  ---- Note need to run :MetalsUpdate to update to the latest server setting
  ---- to set explicit server version, set the following
  -- serverVersion = "1.0.0",
}

-- Consider turning this one after mvoing to lualine, more detail see https://github.com/scalameta/nvim-metals/discussions/39
-- metals_config.init_options.statusBarProvider = "on"

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
