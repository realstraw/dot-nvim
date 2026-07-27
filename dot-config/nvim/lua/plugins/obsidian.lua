return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  -- Lazy-load: the plugin spins up on first use rather than at startup, so
  -- unrelated nvim sessions stay light. `cmd` covers any :Obsidian command;
  -- `keys` adds the shortcut. Note: the lualine sync icon stays blank and
  -- continuous sync won't auto-resume until the plugin is first triggered.
  cmd = "Obsidian",
  keys = {
    { "<Leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian: today's daily note" },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "personal",
        path = "~/Obsidian/notes",
      },
    },
    -- Mirror the Obsidian app's Daily Notes settings (.obsidian/daily-notes.json).
    -- obsidian.nvim does not read the app config, so keep these in sync manually.
    daily_notes = {
      folder = "2 Areas/Journal",
      date_format = "YYYY/MM/YYYY-MM-DD",
      -- Separate from the app's Templater template (which obsidian.nvim can't run).
      template = "Daily Note (nvim)",
      default_tags = {},
      workdays_only = false,
    },
    templates = {
      folder = "5 Templates",
      -- Equivalents for the app's Templater daily-note template. Dates are derived
      -- from the note's own date (its id, "YYYY-MM-DD") so prev/next are correct.
      substitutions = {
        -- Current timestamp for the `created` frontmatter field.
        created = function()
          return os.date("%Y-%m-%d %H:%M:%S")
        end,
        -- Shared daily-note content, kept in one file so the app's Templater
        -- template and this one stay in sync. Edit "5 Templates/Daily Note Body.md".
        body = function()
          local path = vim.fs.joinpath(tostring(Obsidian.dir), "5 Templates", "Daily Note Body.md")
          local ok, lines = pcall(vim.fn.readfile, path)
          if not ok then
            return ""
          end
          return table.concat(lines, "\n")
        end,
        -- The note's date, e.g. "2026-07-26".
        note_date = function(ctx)
          return ctx.partial_note and ctx.partial_note.id
        end,
        prev_day = function(ctx)
          local id = ctx.partial_note and ctx.partial_note.id
          local y, m, d = tostring(id):match("(%d+)-(%d+)-(%d+)")
          if not y then
            return ""
          end
          local t = os.time({ year = y, month = m, day = d, hour = 12 }) - 86400
          return os.date("%Y-%m-%d", t)
        end,
        next_day = function(ctx)
          local id = ctx.partial_note and ctx.partial_note.id
          local y, m, d = tostring(id):match("(%d+)-(%d+)-(%d+)")
          if not y then
            return ""
          end
          local t = os.time({ year = y, month = m, day = d, hour = 12 }) + 86400
          return os.date("%Y-%m-%d", t)
        end,
      },
    },
    -- Don't auto-inject/update a YAML frontmatter block (id/aliases/tags) on save.
    frontmatter = {
      enabled = false,
    },
    -- render-markdown.nvim handles markdown rendering; disable obsidian's own UI
    -- to avoid two renderers conflicting (and the conceallevel warning).
    ui = {
      enable = false,
    },
  },
}
