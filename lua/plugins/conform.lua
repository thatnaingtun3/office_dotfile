local util = require("conform.util")
local augroup = vim.api.nvim_create_augroup("lsp_blade_workaround", { clear = true })

-- Create an autocmd group for AutoSave functionality
local autosave_group = vim.api.nvim_create_augroup("AutoSaveGroup", { clear = true })

-- Auto-save when focus is lost
vim.api.nvim_create_autocmd("FocusLost", {
  group = autosave_group,
  pattern = "*",
  command = "silent! wall",
})

-- Auto-save on buffer change (insert leave or text changed)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = autosave_group,
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- env warning error
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = ".env*",
--   callback = function()
--     vim.bo.filetype = "env"
--   end,
-- })

return {
  "stevearc/conform.nvim",
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        php = { "pint" },
        blade = { "blade-formatter", "rustywind" },
        python = { "black" },
        javascript = { "prettierd" },
        -- rust = { "rustfmt" },
      },
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   extra_args = { "-i", "2", "-ci" },
        -- },
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },
          command = util.find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
          }, "pint"),
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    }
    return opts
  end,
}
