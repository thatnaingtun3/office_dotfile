return {
  {
    "numToStr/Comment.nvim",
    opts = function(_, opts)
      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      if commentstring_avail then
        opts.pre_hook = commentstring.create_pre_hook()
      end
    end,
  },
  -- Add context commentstring support
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
      languages = {
        blade = "{{-- %s --}}",
      },
    },
  },
}
