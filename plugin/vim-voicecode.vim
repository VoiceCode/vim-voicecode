function! SetVoicecodeMode(newMode)
python << endPython

import vim
import socket

def set_mode():
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect('/tmp/voicecode.sock')
        sock.sendall('set mode {}'.format(vim.eval('a:newMode')))
    except:
        pass

set_mode()

endPython
endfunction

autocmd VimEnter * call SetVoicecodeMode('vimNormal')
autocmd VimLeave * call SetVoicecodeMode('exitedVim')
autocmd InsertEnter * call SetVoicecodeMode('vimInsert')
autocmd InsertLeave * call SetVoicecodeMode('vimNormal')
