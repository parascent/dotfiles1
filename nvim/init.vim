syntax on
:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
set noshowmatch
set mouse=a
set relativenumber
let mapleader = " "
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END


set hlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set foldmethod=indent
set nofoldenable
set wrap
set autoread
set inccommand=split
set mousefocus
set breakindent
set showbreak=\ \\_
set updatetime=700
set exrc
set secure

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

:nmap <leader>e :NERDTreeToggle<CR>
:nmap <space>r :registers<CR>
:vmap <space>r :registers<CR>
"Custom tabstops
"End Custom tabstops

let NERDTreeShowHidden=1
"Switching buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

nnoremap <esc> <esc>
"close inactive buffers
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

"jump between errors
nnoremap [l :lprev<CR>
nnoremap ]l :lnext<CR>
"remap insert mode alt key and arrow keys
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

"jump between git hunks with git gutter
nnoremap <silent> <cr> :GitGutterNextHunk<cr>
nnoremap <silent> <backspace> :GitGutterPrevHunk<cr>
"remap moving in splits in normal modes to ctrl
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


call plug#begin('~/.config/nvim/plugged')

Plug 'dkprice/vim-easygrep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'justinhoward/fzf-neoyank'
Plug 'voldikss/vim-floaterm'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
"Languages
Plug 'rust-lang/rust.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'iloginow/vim-stylus'
Plug 'tpope/vim-commentary'
Plug 'OmniSharp/omnisharp-vim'
"  I AM SO SORRY FOR DOING COLOR SCHEMES IN MY VIMRC, BUT I HAVE
"  TOOOOOOOOOOOOO
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'ryanoasis/vim-devicons'
Plug 'pacha/vem-tabline'
Plug 'machakann/vim-highlightedyank'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
"Plug 'majutsushi/tagbar'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'rhysd/clever-f.vim'
" Plug 'hushicai/tagbar-javascript.vim'
Plug 'preservim/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-abolish'
Plug 'posva/vim-vue'
Plug 'yuttie/comfortable-motion.vim'
Plug 'vim-scripts/loremipsum'
Plug 'wesQ3/vim-windowswap'

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'eliba2/vim-node-inspect'
call plug#end()



fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" <Plug>VimspectorStop
" <Plug>VimspectorPause
" <Plug>VimspectorAddFunctionBreakpoint


"highlightedyank
let g:highlightedyank_highlight_duration = -1
"confortable scroll
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

"autosave
" autocmd CursorHold * update
nmap <C-s> :w<CR>

let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
map s <Plug>Sneak_s
map S <Plug>Sneak_S
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"
"icons
let g:vem_tabline_show_icon = 0

nmap cc gcc

function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let selection = join(lines,'\n')
  return ":Ag /".selection."/"
  "return selection
  " let change = input('Change the selection with: ')
  " execute ":%s/".selection."/".change."/g"
endfunction

nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <F8>   :FloatermNew lazygit<CR>
tnoremap   <silent>   <F8>   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <F7>   :Ag<CR>
nnoremap   <silent>   <F7>   :Ag<CR>
vnoremap    <expr>   <F7>Get_visual_selection()<CR>
tnoremap   <silent>   <F7>   :FloatermToggle<CR>
"easyclip rempaps m to cut so here remapping gm to do m or mark
nnoremap gm m
"syntastic stuff
let g:syntastic_stl_format = '[%E{E:%e(#%fe)}%B{,}%W{W:%w(#%fw)}]'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_typescript_checkers=['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:vue_pre_processors = 'detect_on_enter'

nnoremap <space>n :noh<CR>
"omnisharp options
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_start_without_solution = 1

" fzf window settings
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
"airline setting
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_gruvbox_dark_hard'

let g:gruvbox_contrast_dark = 'hard'

" --- The Greatest plugin of all time.  I am not bias
let g:vim_be_good_floating = 1
nmap <F2> :TagbarToggle<CR>
" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

let g:neoyank#save_registers = ['+','*']

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^

" map f <Plug>Sneak_s
" map F <Plug>Sneak_S

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

"working with split windows
nnoremap <M-j> <C-W><C-j>
nnoremap <M-k> <C-W><C-k>
nnoremap <M-l> <C-W><C-l>
nnoremap <M-h> <C-W><C-h>
"insert mode arrow keys with hjkland alt

set clipboard=unnamed,unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

nmap <leader>b :Buffers<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>ff :Ag<CR>
nmap <leader>fp :Files<CR>
nmap <leader>ft :BTags<CR>
nmap <leader>fr :Tags<CR>
" vmap <leader>b :CocList buffers<CR>
" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<CR>
" nnoremap <C-p> :GFiles --exclude-standard --others --cached<CR>
" add below to fish config
" set -Ux FZF_DEFAULT_COMMAND 'fd --type f'
nnoremap <C-p> :Files<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <C-b> :Buffers<CR>
" Vim with me
nnoremap <leader>vwm :colorscheme gruvbox<bar>:set background=dark<CR>
nmap <leader>vtm :highlight Pmenu ctermbg=gray guibg=gray

nnoremap x d
vnoremap x d
nnoremap xx dd
vnoremap xx dd

inoremap <C-c> <esc>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

"autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype vue setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType typescript setlocal commentstring=//\ %s
autocmd FileType vue setlocal commentstring=//\ %s
autocmd FileType pug setlocal commentstring=//-\ %s

"Denite mappings because of neoyank
" Define mappings
let g:AutoPairsShortcutToggle = ''
nmap <A-p> :Denite neoyank<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction


autocmd BufWritePre * :call TrimWhitespace()
