-- モードに応じたカーソル形状を設定
vim.opt.guicursor = 'n-v-c:hor20,i-ci-ve:ver25,r-cr:hor20,o:hor50'

-- lazy.nvim のブートストラップ
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 基本設定 / キーバインドの読み込み
local config_dir = vim.fn.stdpath('config')
vim.cmd('source ' .. config_dir .. '/basic.vimrc')
vim.cmd('source ' .. config_dir .. '/key_bind.vimrc')

-- coc.nvim の extensions (coc.nvim が読み込まれる前に設定する必要がある)
vim.g.coc_global_extensions = {
  'coc-go',
  'coc-json',
  'coc-yaml',
  'coc-tsserver',
  'coc-prettier',
  'coc-phpls',
  'coc-snippets',
  'coc-toml',
  'coc-rust-analyzer',
}

-- プラグインの読み込み
require('lazy').setup('plugins')
