let s:path = expand('<sfile>:p:h')
call remote#host#RegisterPlugin('python3', s:path.'/chatvim.py', [
      \ {'sync': v:false, 'name': 'LLMResponse', 'type': 'function', 'opts': {}},
     \ ])
" Define the normal mode mappings
nnoremap <silent> <leader>g :call LLMResponse()<CR>
nnoremap <silent> <leader>cc :edit ~/.config/chatvim/chats/chats.md<CR>
