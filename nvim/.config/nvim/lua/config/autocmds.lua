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

--   :MdToPdf           -> title = file name
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

      local infile   = vim.fn.expand("%:p")
      local basename = vim.fn.expand("%:t:r")
      local outfile  = vim.fn.expand("~/Downloads/") .. basename .. ".pdf"

      local args = {
        infile,
        "-o", outfile,
        "--from=markdown+autolink_bare_uris",
        "--pdf-engine=xelatex",
      }

      if opts.bang then
        table.insert(args, "--variable")
        table.insert(args, "title=")
      elseif opts.args and #opts.args > 0 then
        table.insert(args, "--metadata")
        table.insert(args, "title=" .. opts.args)
      else
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
              local msg = "Exported → " .. outfile
              if is_fallback then
                msg = msg .. " (via fallback engine: " .. engine .. ")"
                vim.notify(msg, vim.log.levels.WARN, { title = "MdToPdf" })
              else
                vim.notify(msg, vim.log.levels.INFO, { title = "MdToPdf" })
              end
            else
              if engine == "xelatex" and vim.fn.executable("wkhtmltopdf") == 1 then
                vim.notify(
                  "xelatex failed, retrying with wkhtmltopdf…",
                  vim.log.levels.WARN,
                  { title = "MdToPdf" }
                )
                run_with("wkhtmltopdf", true)
              else
                vim.notify("Pandoc failed:\n" .. (obj.stderr or obj.stdout or ""), vim.log.levels.ERROR, { title = "MdToPdf" })
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
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt_local.textwidth = 80
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWinLeave", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt_local.textwidth = 0
--   end,
-- })
