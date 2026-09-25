return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    {
      "mfussenegger/nvim-dap",
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require("dap")

        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }
      end
    },
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "pekko.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl" ,
        "com.github.swagger.pekko.javadsl" 
      },
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to either "off" or "on"
    --
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = "off"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- metals_config.on_attach = function(client, bufnr)
    --   require("metals").setup_dap()

    --   -- LSP mappings
    --   map("n", "gD", vim.lsp.buf.definition)
    --   map("n", "K", vim.lsp.buf.hover)
    --   map("n", "gi", vim.lsp.buf.implementation)
    --   map("n", "gr", vim.lsp.buf.references)
    --   map("n", "gds", vim.lsp.buf.document_symbol)
    --   map("n", "gws", vim.lsp.buf.workspace_symbol)
    --   map("n", "<leader>cl", vim.lsp.codelens.run)
    --   map("n", "<leader>sh", vim.lsp.buf.signature_help)
    --   map("n", "<leader>rn", vim.lsp.buf.rename)
    --   map("n", "<leader>f", vim.lsp.buf.format)
    --   map("n", "<leader>ca", vim.lsp.buf.code_action)

    --   map("n", "<leader>ws", function()
    --     require("metals").hover_worksheet()
    --   end)

    --   -- all workspace diagnostics
    --   map("n", "<leader>aa", vim.diagnostic.setqflist)

    --   -- all workspace errors
    --   map("n", "<leader>ae", function()
    --     vim.diagnostic.setqflist({ severity = "E" })
    --   end)

    --   -- all workspace warnings
    --   map("n", "<leader>aw", function()
    --     vim.diagnostic.setqflist({ severity = "W" })
    --   end)

    --   -- buffer diagnostics only
    --   map("n", "<leader>d", vim.diagnostic.setloclist)

    --   map("n", "[c", function()
    --     vim.diagnostic.goto_prev({ wrap = false })
    --   end)

    --   map("n", "]c", function()
    --     vim.diagnostic.goto_next({ wrap = false })
    --   end)

    --   -- Example mappings for usage with nvim-dap. If you don't use that, you can
    --   -- skip these
    --   map("n", "<leader>dc", function()
    --     require("dap").continue()
    --   end)

    --   map("n", "<leader>dr", function()
    --     require("dap").repl.toggle()
    --   end)

    --   map("n", "<leader>dK", function()
    --     require("dap.ui.widgets").hover()
    --   end)

    --   map("n", "<leader>dt", function()
    --     require("dap").toggle_breakpoint()
    --   end)

    --   map("n", "<leader>dso", function()
    --     require("dap").step_over()
    --   end)

    --   map("n", "<leader>dsi", function()
    --     require("dap").step_into()
    --   end)

    --   map("n", "<leader>dl", function()
    --     require("dap").run_last()
    --   end)
    -- end

    return metals_config
  end,

  config = function(self, metals_config)
    -- >>> BEGIN Metals semantic-tokens cascade fix (remove once fixed upstream:
    --     https://github.com/scalameta/metals/issues/8887) >>>
    -- Work around a Metals semantic-tokens bug. When a string interpolation
    -- ($ident) sits at column 0 inside a multi-line interpolated string, Metals
    -- emits that token with a deltaLine one short: the preceding blank line is
    -- dropped. Because the LSP token stream is delta-encoded, that single missing
    -- line shifts EVERY later token up one line for the rest of the file,
    -- corrupting the highlighting of the string and of all real code after it.
    -- Neovim decodes the stream faithfully; the bad deltas come from Metals.
    --
    -- We repair the flat token array before Neovim decodes it. Metals never
    -- tokenizes a truly-empty line, so any token landing on one means the stream
    -- under-counted earlier; we bump that token's deltaLine down to the next
    -- non-empty line, which re-aligns the whole cascade in one idempotent pass
    -- (only integer values change, never the array length, so it is self-healing
    -- across edits). NOTE: this reaches into vim.lsp.semantic_tokens internals and
    -- may need revisiting on a Neovim upgrade; drop it once Metals fixes the bug.
    local STH = vim.lsp.semantic_tokens.__STHighlighter
    if STH and not STH.__scala_interp_repair then
      STH.__scala_interp_repair = true
      local orig_process_response = STH.process_response

      local function repair_metals_tokens(data, bufnr)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local nlines = #lines
        local line ---@type integer?
        for i = 1, #data, 5 do
          local dl = data[i]
          line = line and (line + dl) or dl
          local len = data[i + 2]
          -- A token can only start on an empty line if Metals dropped a line
          -- earlier. Shift it (and, via the delta chain, every following token)
          -- down to the next non-empty line.
          if len > 0 and lines[line + 1] == "" then
            local target = line
            while target < nlines - 1 and lines[target + 1] == "" do
              target = target + 1
            end
            if target ~= line then
              data[i] = dl + (target - line)
              line = target
            end
          end
        end
      end

      STH.process_response = function(hl, response, client, request_id, version, is_range_request)
        -- Only touch full (non-range) Metals responses. Range responses are
        -- transient and superseded by the full result we repair here.
        if client and client.name == "metals" and not is_range_request and response and response.data then
          -- Force full (non-delta) responses so we always receive the complete
          -- flat array here and never have to reconstruct server-side edits.
          local state = hl.client_state and hl.client_state[client.id]
          if state then
            state.supports_delta = false
          end
          repair_metals_tokens(response.data, hl.bufnr)
        end
        return orig_process_response(hl, response, client, request_id, version, is_range_request)
      end
    end
    -- <<< END Metals semantic-tokens cascade fix <<<

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
