-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Auto-save current buffer on various "focus lost" events
-- Auto-save on FocusLost, BufLeave, or TermOpen
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "TermOpen", "VimLeavePre" }, {
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].modifiable and vim.bo[buf].modified and vim.bo[buf].buftype == "" then
      vim.cmd("silent! write")
    end
  end,
  desc = "Auto-save current buffer on focus loss, buffer switch, terminal open, or exiting Neovim",
})

--   :MdToPdf           -> title = frontmatter title, or file name if no frontmatter title
--   :MdToPdf!          -> no title
--   :MdToPdf My Report -> title = "My Report"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.api.nvim_buf_create_user_command(event.buf, "MdToPdf", function(opts)
      if vim.fn.executable("pandoc") == 0 then
        vim.notify("pandoc not found in PATH", vim.log.levels.ERROR)
        return
      end

      if vim.bo.modified then
        vim.cmd.write()
      end

      local infile     = vim.fn.expand("%:p")
      local basename   = vim.fn.expand("%:t:r")
      local outfile    = vim.fn.expand("~/Downloads/") .. basename .. ".pdf"
      local infile_dir = vim.fn.fnamemodify(infile, ":h")

      local function clean_line(line)
        line = line or ""
        -- Remove UTF-8 BOM if present, then trim whitespace.
        line = line:gsub("^\239\187\191", "")
        return vim.trim(line)
      end

      local function markdown_has_frontmatter_title(path)
        local ok, lines = pcall(vim.fn.readfile, path, "", 120)
        if not ok or not lines or #lines == 0 then
          return false
        end

        -- YAML frontmatter must start at the top of the file.
        if clean_line(lines[1]) ~= "---" then
          return false
        end

        for i = 2, #lines do
          local line = clean_line(lines[i])

          -- End of YAML frontmatter.
          if line == "---" or line == "..." then
            return false
          end

          -- Match:
          -- title: Something
          -- title:
          --   Something
          if line:match("^title%s*:") then
            return true
          end
        end

        return false
      end

      local args = {
        infile,
        "-o", outfile,
        "--from=markdown+yaml_metadata_block+autolink_bare_uris",
        "--pdf-engine=xelatex",
        "--resource-path=" .. infile_dir,
      }

      if opts.bang then
        -- :MdToPdf! -> force no title
        table.insert(args, "--variable")
        table.insert(args, "title=")
      elseif opts.args and #opts.args > 0 then
        -- :MdToPdf My Report -> explicit command title wins
        table.insert(args, "--metadata")
        table.insert(args, "title=" .. opts.args)
      elseif markdown_has_frontmatter_title(infile) then
        -- :MdToPdf with frontmatter title -> let Pandoc use it
      else
        -- :MdToPdf with no frontmatter title -> use filename
        table.insert(args, "--metadata")
        table.insert(args, "title=" .. basename)
      end

      local function run_with(engine, is_fallback)
        local full = { "pandoc" }
        vim.list_extend(full, args)

        for i, v in ipairs(full) do
          if v:match("^%-%-pdf%-engine=") then
            full[i] = "--pdf-engine=" .. engine
          end
        end

        vim.system(full, { text = true }, function(obj)
          vim.schedule(function()
            if obj.code == 0 then
              local msg = "Exported -> " .. outfile

              if is_fallback then
                msg = msg .. " (via fallback engine: " .. engine .. ")"
                vim.notify(msg, vim.log.levels.WARN, { title = "MdToPdf" })
              else
                vim.notify(msg, vim.log.levels.INFO, { title = "MdToPdf" })
              end
            else
              if engine == "xelatex" and vim.fn.executable("wkhtmltopdf") == 1 then
                vim.notify(
                  "xelatex failed, retrying with wkhtmltopdf...",
                  vim.log.levels.WARN,
                  { title = "MdToPdf" }
                )
                run_with("wkhtmltopdf", true)
              else
                vim.notify(
                  "Pandoc failed:\n" .. (obj.stderr or obj.stdout or ""),
                  vim.log.levels.ERROR,
                  { title = "MdToPdf" }
                )
              end
            end
          end)
        end)
      end

      run_with("xelatex", false)
    end, {
      nargs = "*",
      bang = true,
      desc = "Export Markdown to PDF (Downloads)",
    })

    vim.keymap.set("n", "<leader>md", function()
      vim.cmd("MdToPdf")
    end, {
      buffer = event.buf,
      desc = "Export Markdown to PDF (Downloads)",
      silent = true,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.keymap.set("n", "<leader>ml", function()
      local max = 0
      local line_num = 0

      for i = 1, vim.api.nvim_buf_line_count(0) do
        local len = vim.fn.strlen(vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1])
        if len > max then
          max = len
          line_num = i
        end
      end

      vim.notify("line " .. line_num .. " has " .. max .. " chars")
    end, {
      buffer = args.buf,
      desc = "Find longest line in Markdown file",
    })
  end,
})
