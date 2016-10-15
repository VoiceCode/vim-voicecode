# vim-voicecode

A Vim plug-in that allows interfacing with VoiceCode by communicating the
current vim mode to the VoiceCode api. This plug-in works in conjunction with
[vim](http://updates.voicecode.io/packages/vim) to extend the stock VoiceCode commands
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

The plug-in works by sending events to VoiceCode whenever a Vim buffer is
opened/closed or you enter/exit insert mode. If you are inside vim and switch
applications, when you switch back to vim it's possible that VoiceCode's state may not
be in sync and won't be reset until you enter/exit insert mode again.

## Adding Custom Commands

This plug-in sends the current vim mode as well as the current file type/extension
to VoiceCode.

Below is an example of a file type aware function definition command. The command
will insert the desired function declaration depending upon what language we
are using.

``` javascript
vim = Packages.get('vim');

MyCoolVimPackage.commands({
  'my-command': {
    spoken: 'deaf',
    description: "File type aware function definition",
    tags: ["text"],
    grammarType: 'textCapture',
    scope: 'vim:terminal', // important
    action: function(input) {
      if (vim.state.mode === "normal") { this.key("I"); }
      if (vim.state.fileType === "python") {
        this.string("def ");
        if (input) {
          this.string(Transforms.snake(input));
          this.string("():");
          this.key("Left");
          this.key("Left");
        }
      } else if (vim.state.fileType === "clojure") {
        this.string("(defn ");
        if (input) {
          this.string(Transforms.spine(input));
          this.string(")");
          this.key("Left");
        }
      }
    }
  }
});

```
