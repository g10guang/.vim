let os = "linux"
if has('unix')
  if has('mac')
    let os = "mac"
  endif
endif

let env = system("systemd-detect-virt")
let tokens = split(env, "\n")
if len(tokens) > 0
  let env = tokens[0]
endif

set nocompatible
set pastetoggle=<F9> "raw copy, do not use auto indent etc.
set clipboard=unnamed
set mouse-=a "disable visual mode
set modifiable  " nerdtree create dir/file
set backspace=indent,eol,start
set shell=/bin/bash

"=============================== encoding ===============================
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set encoding=utf-8
"=============================== encoding ===============================

set nu "show number
set cursorline "突出显示当前行
set showmatch "colorscheme evening
set laststatus=2 "always show status line
set showcmd
set ruler

set ic "ignore case
set hlsearch "hightlight search
set incsearch "when searching book, when type /b will automatically find in c search

" syntax
syntax enable
syntax on

filetype plugin on
filetype indent on

" indent
set autoread
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab "2 backspace to replace a tab
set colorcolumn=121

" nobackup
set nobackup
set nowb
set noswapfile
if v:version >= 800
  set noundofile
endif
set maxmempattern=5000

" go back the previvous cursor location
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 插件开始的位置
call plug#begin('~/.plugged')

" start screen for vim
Plug 'mhinz/vim-startify'

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'

" comment and uncomment
Plug 'preservim/nerdcommenter'

" 自动补全括号的插件,包括小括号,中括号,以及花括号
Plug 'jiangmiao/auto-pairs'
" colored parentheses
Plug 'luochen1990/rainbow'

" Vim状态栏插件,包括显示行号,列号,文件类型,文件名,以及Git状态
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" 有道词典在线翻译
Plug 'ianva/vim-youdao-translater'

" conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree'

" View and search LSP symbols, tags in Vim/NeoVim
Plug 'liuchengxu/vista.vim'

" markdown 插件
if os == "mac"
  Plug 'iamcco/mathjax-support-for-mkdp'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
endif

Plug 'solarnz/thrift.vim'

" 配色方案
" colorscheme neodark
Plug 'KeitaNakamura/neodark.vim'
" colorscheme monokai
Plug 'crusoexia/vim-monokai'
" colorscheme github
Plug 'acarapetis/vim-colors-github'
" colorscheme one
Plug 'rakr/vim-one'
" colorscheme codedark
Plug 'tomasiser/vim-code-dark'

Plug 'kevinoid/vim-jsonc'

" 插件结束的位置,插件全部放在此行上面
call plug#end()


"==============================================================================
" 主题配色
"==============================================================================
" 开启24bit的颜色,开启这个颜色会更漂亮一些
set termguicolors
" 配色方案, 可以从上面插件安装中的选择一个使用
colorscheme codedark
set background=dark " 主题背景 dark-深色; light-浅色


" startify
let g:startify_change_to_dir = 0


" fzf
" 查看文件列表
nmap <C-p> :Files<CR>
" 查看当前 Buffer, 两次 Ctrl + e 快速切换上次打开的 Buffer
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit' }


"==============================================================================
" junegunn/vim-easy-align
"==============================================================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"==============================================================================
" preservim/nerdcommenter
"==============================================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


"==============================================================================
" liuchengxu/vista.vim
"==============================================================================
let g:vista_stay_on_open = 0
let g:vista_sidebar_width = 50
let g:vista_executive_for = {
  \ 'cpp': 'coc',
  \ 'go': 'coc',
  \ }


"==============================================================================
" ianva/vim-youdao-translater
"==============================================================================
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

let g:rainbow_active = 1

"==============================================================================
" 其他插件配置
"==============================================================================
" markdwon 的快捷键
map <silent> <F5> <Plug>MarkdownPreview
map <silent> <F6> <Plug>StopMarkdownPreview

hi comment ctermfg=6  " comment color

" 兼容 ctags 的跳转方式
map <C-]> gd

" 设置默认 shell 使用 zsh，而不是 bash
set shell=/bin/zsh

autocmd CursorHold * silent call CocActionAsync('highlight')

" kevinoid/vim-jsonc plugin
autocmd FileType json syntax match Comment +\/\/.\+$+
