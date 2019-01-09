"#####leader設定#####
" leaderをSpaceキーにする
let mapleader = "\<Space>"

"#####プラグイン設定#####
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" file tree
Plug 'scrooloose/nerdtree'
call plug#end()

"#####テキスト設定#####
set autowrite

"#####コピー&ペーストの設定#####
set clipboard+=unnamed

"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース2つ分に設定
set shiftwidth=2  " 自動インデントでずれる幅
set smartindent "オートインデント
set cursorline " カーソル行の背景色を変える
set backspace=indent,eol,start "バックスペースが効かなくなる事象に対しての対応策

"#####NERDTree設定#####
nnoremap <leader>o :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks=1
nnoremap <Tab> <C-w>w
" ファイル指定せずvimを起動したらNERDTreeを表示する
" ファイル指定して起動した場合はNERDTreeを表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"#####コマンド設定#####
"" インサートモードの時に C-j でノーマルモードに戻る
imap <C-j> <esc>
" クイックフィクスリストの次の要素に移動する
map <C-n> :cnext<CR>
" クイックフィクスリストの前の要素に移動する
map <C-p> :cprevious<CR>
" クイックフィクスリスト閉じる
nnoremap <leader>a :cclose<CR>

" #####vim-goの設定#####
" ショートカット
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)
au FileType go nmap <silent> <leader>fs :GoFillStruct<CR>
au FileType go nmap <silent> <leader>ei :GoIfErr<CR>
au FileType go nmap <silent> <leader>ip :GoImpl<CR>

let g:go_highlight_types = 1
" let g:go_highlight_function_calls = 1

" 保存時にgoimportsを実行する
let g:go_fmt_command = "goimports"

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"#####マウス設定#####
set mouse=a

"行番号の色を変更
highlight LineNr ctermfg=239

" --- vimのタブに関する設定 ---
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

