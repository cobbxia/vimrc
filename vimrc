" git clone https://github.com/gmarik/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
noremap <F11> :!cscope -Rbq -I/usr/local/include <CR><CR>:cs reset<CR><CR>
noremap <F12> :!ctags -R --languages=c++  --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=$HOME/.vim/systags " System Tags
set nocompatible              " be iMproved, required
filetype on                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" taglist on right srceen
Plugin 'vim-scripts/taglist.vim'
map <F5> :Tlist<cr>
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1 
let Tlist_Use_Left_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1

" file/dir tree
" Plugin 'scrooloose/nerdtree'
" map <F4> :NERDTree<cr>

" locate files
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'     "hotkey Ctrl+p open ctrlp plugin
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = '0'       "disable work path mode

" function list
Plugin 'tacahiroy/ctrlp-funky'
map <F6> :CtrlPFunky<cr>
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1 

" OmniCppComplete c+x,c+o
" 插件的具体文档可以阅读 :help omnicppcomplete
Plugin 'OmniCppComplete'
let OmniCpp_NamespaceSearch = 2  " default 1，2: search namespaces in the current buffer and in included files
let OmniCpp_GlobalScopeSearch = 1  " default 1, enable global scope search
let OmniCpp_ShowAccess = 1  " 默认0，自动选择；1为显示所有public, protected,private成员
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]  "
" 当解析名称空间时的默认名称空间
let OmniCpp_MayCompleteDot = 1  " 输入 . 后进行自动完成
let OmniCpp_MayCompleteArrow = 1  " 输入 -> 后进行自动完成
let OmniCpp_MayCompleteScope = 1  " 输入 :: 后进行自动完成
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif "close automatically the preview window after a completion
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"tab 键替代
":help ins-completion
"Plugin 'supertab.vmb'


Plugin 'winmanager'
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
noremap <c-w><c-t> :WMToggle<cr>  
noremap <c-w><c-f> :FirstExplorerWindow<cr>  
noremap <c-w><c-b> :BottomExplorerWindow<cr>


"Plugin 'cppcomplete' 
"Plugin 'Cpp11-Syntax-Support'


" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"set tags=/home/mingchao.xiamc/mygit/cppcheckII/tags
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr> " And load session with F3

" 显示外观
set number  " 显示行号
set wrap  " 显示行号的情况下更适合自动换行
set background=dark  " 在控制台下，使字体颜色更加明亮
set showcmd  " 状态栏显示命令或部分命令
set showmatch  " 显示匹配的括号
set cursorline  " 高亮显示当前行
set laststatus=2 " 总是显示文件状态栏
" 获取当前的路径，将$HOME转化为~
function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction

"格式
set autoindent  " 自动缩进
set smartindent  " 智能缩进，只在autoindent打开时有效
set cindent  " C/C++风格缩进


"动作
set paste

" 切换时自动加载 cscope.out 文件
function! LoadCscope()
  if has("cscope")
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      exe "cs add " . db . " " . path
    endif
  endif
endfunction
"au BufEnter /* call LoadCscope()

" 启动时自动加载 cscope.out
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0  " 先搜索 cscope 文件，再搜索 tag 文件，默认就是 0，如果是 1，则先搜索 tag
  set cst  " :tag 和 CTRL-] 都会使用 cscope tag 而不是原来的 ctags
  set nocsverb  " No Cscopse Verbose
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""                                                                                                         
    cs add $CSCOPE_DB
  endif
  set csverb
endif


"自动cppcheck
"if exists("cppcheck2")
"  finish
"endif
"let current_compiler = \"cppcheck2\"
"
"let s:cpo_save = &cpo
"set cpo-=C
"
"setlocal makeprg=cppcheck2\ --enable=all\ .
"setlocal errorformat=\[%f:%l\]:\ (%t%s)\ %m
"
"let &cpo = s:cpo_save
"unlet s:cpo_save

"vim: ft=vim


