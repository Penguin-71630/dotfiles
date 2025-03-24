" map-table 
"          模式  | Norm | Ins | Cmd | Vis | Sel |
" 命令           +------+-----+-----+-----+-----+
" [nore]map      | yes  |  -  |  -  | yes | yes |
" n[nore]map     | yes  |  -  |  -  |  -  |  -  |
" [nore]map!     |  -   | yes | yes |  -  |  -  |
" i[nore]map     |  -   | yes |  -  |  -  |  -  |
" c[nore]map     |  -   |  -  | yes |  -  |  -  |
" v[nore]map     |  -   |  -  |  -  | yes | yes |
" x[nore]map     |  -   |  -  |  -  | yes |  -  |
" s[nore]map     |  -   |  -  |  -  |  -  | yes |
" o[nore]map     |  -   |  -  |  -  |  -  |  -  |
" t[nore]map     |  -   |  -  |  -  |  -  |  -  |
" l[nore]map     |  -   | yes | yes |  -  |  -  |


" Basics "
syn on
set ai nu rnu ru cul mouse=a
set cin et ts=4 sw=4 sts=4
set autochdir
set clipboard=unnamedplus


" 禁用所有檔案的折疊功能
set foldlevel=99


" Chinese "
set fileencodings=ucs-bom,utf-8,big5,gbk,latin1


" Color "
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors
set term=xterm-256color

if filereadable(expand("~/.cache/wal/colors-wal.vim"))
    source ~/.cache/wal/colors-wal.vim"
endif

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" Faster Cursor Navigation "
no h b
no l e
no b l
no e h
no <C-h> ^
no <C-l> $
no <C-k> 4<C-y>4k
no <C-j> 4<C-e>4j

" File Saving "
no  <C-s> <Esc><Esc>:w<CR>
ino <C-s> <Esc>:w<CR>a
no  <C-q> <Esc><Esc>:wq<CR>
ino <C-q> <Esc><Esc>:wq<CR>


" For CF "
:command! -nargs=1 Goto execute 'buffer ' . (char2nr('<args>') - char2nr('A') + 1)
:command! -nargs=0 Run execute '!runtest ' . expand('%:p')

" Fix the problem that I always mistype ':' as ';' "
nno ; :


" Vim-plug "
call plug#begin()
Plug 'tpope/vim-sensible'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

"""" set nocompatible              " be iMproved, required
"""" filetype off                  " required

" set the runtime path to include Vundle and initialize
"""" set rtp+=~/.vim/bundle/Vundle.vim
"""" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"""" Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"""" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"""" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"""" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"""" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All of your Plugins must be added before the following line
"""" call vundle#end()            " required
"""" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
