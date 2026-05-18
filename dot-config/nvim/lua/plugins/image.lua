return {
  "3rd/image.nvim",
  build = false,
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
        resolve_image_path = function(document_path, image_path, fallback)
          -- strip Jekyll Liquid prefixes
          local stripped = image_path:gsub("^{{%s*site%.baseurl%s*}}", "")
                                     :gsub("^{{%s*site%.url%s*}}", "")
          if stripped ~= image_path then
            -- find the Jekyll site root by walking up from the document
            local dir = vim.fn.fnamemodify(document_path, ":h")
            while dir ~= "/" do
              if vim.fn.filereadable(dir .. "/_config.yml") == 1 then
                return dir .. stripped
              end
              dir = vim.fn.fnamemodify(dir, ":h")
            end
          end
          return fallback(document_path, image_path)
        end,
      },
    },
    max_width = 80,
    max_height = 80,
    -- max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = true,
  },
}
