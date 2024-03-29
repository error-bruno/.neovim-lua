local opt = vim.opt

-- Global
vim.g.mapleader = ","

-- General
opt.nu = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Movement
opt.scrolloff = 99

-- Window placement
opt.splitright = true
opt.splitbelow = true
opt.title = true

-- Editing
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.showmatch = true

-- Colors
opt.termguicolors = true

-- Status
opt.showmode = false
opt.showtabline = 0
opt.mouse = "a"
opt.showcmd = false
