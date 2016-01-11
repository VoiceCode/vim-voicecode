# vim-voicecode

A Vim plug-in that allows interfacing with VoiceCode by communicating the
current mode to the VoiceCode api. This plug-in works in conjunction with
[vim](https://github.com/VoiceCode/vim) to extend the stock VoiceCode commands
to work consistently inside terminal Vim.

## Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/VoiceCode/vim-voicecode ~/.vim/bundle/vim-voicecode`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/VoiceCode/vim-voicecode'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/VoiceCode/vim-voicecode'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/VoiceCode/vim-voicecode'` to .vimrc
  - Run `:PlugInstall`

## Known Issues

The plug-in works by updating the VoiceCode mode whenever a Vim buffer is
opened/closed or you enter/exit insert mode. If you are inside vim and switch
applications, when you switch back to vim the VoiceCode mode will have been
cleared and will not be reset until you enter/exit insert mode again.

## Adding Custom Commands

This plug-in provides additional Vim specific modes in VoiceCode, so creating
custom commands is the same as is described in the [VoiceCode Wiki][https://github.com/VoiceCode/docs/wiki].
You can find the additional modes listed [here](https://github.com/VoiceCode/vim/blob/master/mode_extensions.js)

Below is an example of a file type aware function definition command. The command
will insert the desired function declaration depending upon what language we
are using.

``` javascript
Commands.create("deaf", {
  description: "File type aware function definition",
  tags: ["text"],
  grammarType: 'textCapture',
  action: function(input) {
    if (input && this.currentApplication() === "iTerm" && Commands.mode[1] === "Python") {
      if (Commands.mode[0] === "vim-normal") { this.key("I"); }
      this.string("def ");
      this.string(Transforms.snake(input));
      this.string("():");
      this.key("Left");
      this.key("Left");
    } else if (input && this.currentApplication() === "iTerm" && Commands.mode[1] === "Clojure") {
      if (Commands.mode[0] === "vim-normal") { this.key("I"); }
      this.string("(defn ");
      this.string(Transforms.spine(input));
      this.string(")");
      this.key("Left");
   }
  }
});
```
