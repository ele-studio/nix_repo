-- File: ~/.config/nvim/lua/config/keymaps.lua
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- =============================================
-- VS CODE-LIKE SHORTCUTS
-- =============================================

-- Cmd+D for multi-cursor (select word under cursor)
map("n", "<D-d>", "*cgn", { desc = "Select word under cursor (like VS Code Cmd+D)" })
map("v", "<D-d>", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>cgn", { desc = "Select next occurrence" })

-- Cmd+/ for toggle comment (more VS Code-like)
map("n", "<D-/>", "gcc", { desc = "Toggle comment line", remap = true })
map("v", "<D-/>", "gc", { desc = "Toggle comment selection", remap = true })

-- Cmd+Shift+P for command palette (like VS Code)
map("n", "<D-S-p>", "<leader>:", { desc = "Command Palette", remap = true })

-- Cmd+P for quick file search (like VS Code)
map("n", "<D-p>", "<leader><space>", { desc = "Find Files", remap = true })

-- Cmd+Shift+F for global search (like VS Code)
map("n", "<D-S-f>", "<leader>/", { desc = "Global Search", remap = true })

-- Alt+Up/Down to move lines (like VS Code)
map("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- =============================================
-- PRODUCTIVITY SHORTCUTS
-- =============================================

-- Quick save with Cmd+S (additional to Ctrl+S)
map("n", "<D-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<D-s>", "<cmd>w<cr>", { desc = "Save file" })


-- Duplicate line (like Cmd+Shift+D in VS Code)
map("n", "<D-S-d>", "yyp", { desc = "Duplicate line" })
map("v", "<D-S-d>", "y'>p", { desc = "Duplicate selection" })

-- Select all with Cmd+A
map("n", "<D-a>", "ggVG", { desc = "Select all" })

-- Quick escape alternatives
map("i", "jj", "<Esc>", { desc = "Quick escape" })
map("i", "jk", "<Esc>", { desc = "Quick escape" })
map("i", "kk", "<Esc>", { desc = "Quick escape" })
map("i", "hh", "<Esc>", { desc = "Quick escape" })

-- Better indenting (stays in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- =============================================
-- NAVIGATION ENHANCEMENTS
-- =============================================

-- Mac-style Cmd+arrow navigation
map("n", "<D-Left>", "^", { desc = "Jump to beginning of line" })
map("n", "<D-Right>", "$", { desc = "Jump to end of line" })
map("n", "<D-Up>", "gg", { desc = "Jump to top of document" })
map("n", "<D-Down>", "G", { desc = "Jump to bottom of document" })

-- Same for insert mode
map("i", "<D-Left>", "<C-o>^", { desc = "Jump to beginning of line" })
map("i", "<D-Right>", "<C-o>$", { desc = "Jump to end of line" })
map("i", "<D-Up>", "<C-o>gg", { desc = "Jump to top of document" })
map("i", "<D-Down>", "<C-o>G", { desc = "Jump to bottom of document" })

-- Visual mode for selecting with Cmd+Shift+arrows
map("v", "<D-Left>", "^", { desc = "Extend selection to beginning of line" })
map("v", "<D-Right>", "$", { desc = "Extend selection to end of line" })
map("v", "<D-Up>", "gg", { desc = "Extend selection to top of document" })
map("v", "<D-Down>", "G", { desc = "Extend selection to bottom of document" })

-- Center screen when jumping
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Quick window switching (enhanced)
map("n", "<leader>ww", "<C-w>w", { desc = "Switch to next window" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })

-- Tab navigation (like browser tabs)
map("n", "<D-S-[>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<D-S-]>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<D-t>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<D-w>", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- =============================================
-- TEXT EDITING ENHANCEMENTS
-- =============================================

-- Better paste (doesn't overwrite register)
map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Quick word replacement
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", { desc = "Join lines and restore cursor position" })

-- =============================================
-- BUFFER MANAGEMENT ENHANCED
-- =============================================

-- Close all buffers except current
map("n", "<leader>bO", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all buffers except current" })

-- Close buffer but keep window layout
map("n", "<leader>bx", "<cmd>bp|bd #<cr>", { desc = "Close buffer keep window" })

-- Switch to last buffer
map("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Switch to last buffer" })

-- =============================================
-- QUICK TOGGLES
-- =============================================

-- Toggle relative line numbers
map("n", "<leader>tr", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })

-- Toggle word wrap
map("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrap" })

-- Toggle invisible characters
map("n", "<leader>ti", "<cmd>set list!<cr>", { desc = "Toggle invisible chars" })

-- =============================================
-- TERMINAL ENHANCEMENTS
-- =============================================

-- Better terminal navigation
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Quick terminal toggle
map("n", "<D-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("t", "<D-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- =============================================
-- DEVELOPMENT SHORTCUTS
-- =============================================

-- Quick find and replace in file
map("n", "<leader>fr", ":%s//g<Left><Left>", { desc = "Find and replace in file" })

-- Source current file (for lua config editing)
map("n", "<leader><CR>", "<cmd>source %<cr>", { desc = "Source current file" })

-- Format current file
map("n", "<D-S-i>", "<leader>cf", { desc = "Format file", remap = true })

-- Quick vertical split with file finder
map("n", "<leader>vf", "<cmd>vsplit<cr><leader><space>", { desc = "Vertical split + find file", remap = true })

-- =============================================
-- COPY/PASTE ENHANCEMENTS
-- =============================================

-- Cmd+C to copy (visual selection or current line)
map("v", "<D-c>", '"+y', { desc = "Copy selection to clipboard" })
map("n", "<D-c>", '"+yy', { desc = "Copy line to clipboard" })

-- Cmd+X to cut (visual selection or current line)
map("v", "<D-x>", '"+x', { desc = "Cut selection to clipboard" })
map("n", "<D-x>", '"+dd', { desc = "Cut line to clipboard" })

-- Cmd+V to paste from clipboard
map("n", "<D-v>", '"+p', { desc = "Paste from clipboard" })
map("i", "<D-v>", '<C-r>+', { desc = "Paste from clipboard" })
map("v", "<D-v>", '"+p', { desc = "Paste from clipboard" })

-- Copy file path to clipboard
map("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<cr>", { desc = "Copy file path" })

-- Copy relative file path to clipboard
map("n", "<leader>cP", "<cmd>let @+ = expand('%')<cr>", { desc = "Copy relative file path" })

-- Copy current line to clipboard
map("n", "<leader>cl", "<cmd>let @+ = getline('.')<cr>", { desc = "Copy current line" })

-- =============================================
-- SEARCH ENHANCEMENTS
-- =============================================

-- Search for word under cursor in project
map("n", "<leader>sw", "<leader>sw", { desc = "Search word under cursor", remap = true })

-- Search for visual selection in project
map("v", "<leader>sw", "<leader>sw", { desc = "Search visual selection", remap = true })

-- Clear search and close quickfix/location lists
map("n", "<leader>q", "<cmd>nohlsearch<bar>cclose<bar>lclose<cr>", { desc = "Clear search and close lists" })

-- =============================================
-- QUICK ACTIONS
-- =============================================

-- Reload Neovim config
map("n", "<leader>R", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Reload Neovim config" })

-- Open Neovim config
map("n", "<leader>C", "<cmd>e ~/.config/nvim/<cr>", { desc = "Open Neovim config" })

-- Quick spell check toggle
map("n", "<F7>", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell check" })

-- Quick quickfix navigation
map("n", "<leader>j", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
map("n", "<leader>k", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })
