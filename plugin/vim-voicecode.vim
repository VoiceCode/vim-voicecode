function! SetVoicecodeMode(newMode)
python << endPython

import vim
import socket

def set_mode():
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect('/tmp/voicecode_events.sock')
        fileType = vim.eval('&ft')
        mode = vim.eval('a:newMode')
        sock.sendall('{{"event":"vim:change-mode","mode":"{}","fileType":"{}"}}'.format(mode, fileType))
    except:
        pass

set_mode()

endPython
endfunction

autocmd VimEnter * call SetVoicecodeMode('normal')
autocmd VimLeave * call SetVoicecodeMode('exited')
autocmd InsertEnter * call SetVoicecodeMode('insert')
autocmd InsertLeave * call SetVoicecodeMode('normal')
