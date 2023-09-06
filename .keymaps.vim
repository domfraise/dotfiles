
"set space to leader
nnoremap <SPACE> <Nop>
let mapleader=" "

"remap re-find
noremap h ;

"Remap left right navigation
noremap ; l
noremap l k
noremap k j
noremap j h

inoremap <C-j> <Left>
inoremap <C-k> <Down>
inoremap <C-l> <Up>
inoremap <C-;> <Right>


"Clipboard copy and paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P :pu+<CR>

"No copy on visual paste
vnoremap p "_dP

"remap escape
inoremap kk <Esc>

"set x to delete without copy
vnoremap x "_d

