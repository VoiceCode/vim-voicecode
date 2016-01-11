function! SetVoicecodeMode(newMode)
python << endPython

import vim
import socket

KNOWN_FILE_TYPES = {"python": "Python",
                    "clojure": "Clojure",
                    "ruby": "Ruby",
                    "c": "C",
                    "coffee": "Coffee",
                    "vim": "Vim",
                    "javascript": "Javascript"}

def set_mode():
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect('/tmp/voicecode.sock')
        file_type = vim.eval('&ft')
        if file_type in KNOWN_FILE_TYPES:
            sock.sendall('set mode {}'.format(''.join([vim.eval('a:newMode'), KNOWN_FILE_TYPES[file_type]])))
        else:
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
