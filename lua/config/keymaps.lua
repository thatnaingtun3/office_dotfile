vim.keymap.set("i", "jk", "<Esc>")
-- Space is my leader.
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")

-- Disable annoying command line typo.
vim.keymap.set("n", "q:", ":q")

-- Paste replace visual selection without copying it.
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "<Leader>h", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Leader>l", ":BufferLineCycleNext<CR>")

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set("i", ";;", "<Esc>A;")
vim.keymap.set("i", ",,", "<Esc>A,")
-- vim.keymap.set("i", "{{", "<Esc>A{")

-- Find and center
local opts = { noremap = true, silent = true }

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Quickly clear search highlighting.
vim.keymap.set("n", "<Leader>k", ":nohlsearch<CR>")

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set("n", "<Leader>x", ":!xdg-open %<CR><CR>")

-- Move lines up and down.
vim.keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi")
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")
-- Compile and run C code

vim.keymap.set("n", "<F5>", ":w<CR>:!gcc % -o %< && (cd %:h && ./%:t:r)<CR>", { noremap = true, silent = true })

-- vim.keymap.set("n", "<F5>", ":w<CR>:!gcc % -o %< && ./%<<CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<F6>",
  ":w<CR>:FloatermNew --autoclose=2 gcc % -o %< && ./%<<CR>",
  { noremap = true, silent = true }
)
