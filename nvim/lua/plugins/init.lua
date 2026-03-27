local config_dir = vim.fn.stdpath('config')

local function source(file)
  return function()
    vim.cmd('source ' .. config_dir .. '/plugins/' .. file)
  end
end

return {
  -- UI
  'itchyny/lightline.vim',
  'airblade/vim-gitgutter',
  'ryanoasis/vim-devicons',
  'nathanaelkane/vim-indent-guides',

  -- Editor
  'machakann/vim-sandwich',
  'thinca/vim-qfreplace',
  'svermeulen/vim-easyclip',
  { 'terryma/vim-expand-region', config = source('vim-expand-region.vim') },

  -- Syntax / Filetype
  -- init を使用して plugin ロード前に globals を設定する
  { 'sheerun/vim-polyglot', init = source('vim-polyglot.vim') },
  { 'yasuhiroki/circleci.vim',  ft = { 'yaml', 'yml' } },
  { 'fgsch/vim-varnish',        ft = { 'vcl' } },
  { 'mechatroner/rainbow_csv',  ft = { 'csv' } },
  { 'gutenye/json5.vim',        ft = { 'json5' } },
  'google/vim-jsonnet',
  'tsandall/vim-rego',
  'itkq/fluentd-vim',
  'jjo/vim-cue',

  -- Git
  { 'tpope/vim-fugitive', config = source('fugitive.vim') },
  { 'tpope/vim-rhubarb',  config = source('vim-rhubarb.vim') },

  -- File explorer
  { 'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/nerdfont.vim',
      'lambdalisue/fern-git-status.vim',
      'lambdalisue/fern-renderer-nerdfont.vim',
    },
    config = source('fern.vim'),
  },

  -- Fuzzy finder
  { 'junegunn/fzf', build = './install --all' },
  { 'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = source('fzf.vim'),
  },

  -- LSP / Completion (Phase 1: coc.nvim を維持)
  { 'neoclide/coc.nvim',
    branch = 'release',
    config = source('coc-vim.vim'),
  },

  -- Snippets
  -- init を使用して plugin ロード前に globals を設定する
  { 'SirVer/ultisnips',
    init = function()
      vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath('config') .. '/UltiSnips' }
      vim.g.UltiSnipsExpandTrigger = '<Down>'
    end,
  },

  -- Go
  { 'mattn/vim-goimports', ft = { 'go' }, config = source('vim-goimports.vim') },

  -- Markdown
  { 'mattn/vim-maketable'},
  { 'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    build = 'cd app && yarn install',
    config = source('markdown-preview.vim'),
  },

  -- Terraform
  { 'hashivim/vim-terraform',
    ft = { 'terraform', 'hcl' },
    config = source('vim-terraform.vim'),
  },

  -- Comments
  { 'preservim/nerdcommenter', config = source('nerdcommenter.vim') },

  -- EditorConfig
  { 'editorconfig/editorconfig-vim', config = source('editorconfig.vim') },

  -- Copilot
  'github/copilot.vim',

  -- denops + kensaku
  'vim-denops/denops.vim',
  { 'lambdalisue/kensaku.vim',
    dependencies = { 'vim-denops/denops.vim' },
  },
  { 'lambdalisue/kensaku-command.vim',
    dependencies = { 'lambdalisue/kensaku.vim' },
  },
  { 'lambdalisue/kensaku-search.vim',
    dependencies = { 'lambdalisue/kensaku.vim' },
    config = source('kensaku-search.vim'),
  },

  -- snacks.nvim + claudecode.nvim
  { 'folke/snacks.nvim',
    config = function()
      require('snacks').setup({})
    end,
  },
  { 'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      require('claudecode').setup()
      vim.cmd('source ' .. config_dir .. '/plugins/claudecode.vim')
    end,
  },
}
