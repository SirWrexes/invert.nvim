# ⇄ Invert.nvim

⚠ THIS IS A WIP.
  For now, only the `invert_at_cursor` function is implemented.
  Breaking changes WILL happen as development of the plugin progresses.

A NeoVim plugin to quickly "invert" text.

-# TODO: Add nice demo gif

## Features

- Smart casing detection:
  Inverses defined in lowercase will work with capitalised/full caps tokens out of the box
- Batch inversion mode:
  Quickly select a bunch of tokens to invert

## Installation

Like any other NeoVim plugin.

- [vim-plug](https://github.com/junegunn/vim-plug): `Plug SirWrexes/invert.nvim`
- [packer.nvim](https://github.com/wbthomason/packer.nvim): `use SirWrexes/invert.nvim`
- [lazy.nvim](https://github.com/folke/lazy.nvim): `{ 'SirWrexes/invert.nvim' }`

## Configuration

Like any other typical NeoVim lua plugin, configuration is done through the `setup()` method: `require('invert').setup(<CONFIG>)`.
Or, if using [lazy.nvim](https://github.com/folke/lazy.nvim), in the `opts` field of your plugin spec.

You can set "global" inverses that will work for any buffer.
Additionally, you can set invereses for specific filetypes. In case there is an overlap between ft-specific
and global inverses, the ft-specific onces will take precedence.

The special key `jslike` in `inverses_by_ft` works for `javascript`, `typescript`, `javascriptreact`, `typescriptreact`.
In case of overlap beetween `jslike` and its corresponding filetypes, the most specific filetype will take precedence.
e.g. `jslike["foo"] = "bar"` VS `typescript["foo"] = "baz"` will result in `foo <-> baz` in TypeScript buffers.

Invert.nvim comes with the following defaults:

```lua
{
  inverses = {
    ['true'] = 'false',
    ['or'] = 'and',
    ['*'] = '/',
    ['+'] = '-',
    ['&&'] = '||',
    ['>'] = '<',
    ['>='] = '<=',
    ['=='] = '!=',
  },
  inverses_by_ft = {
    lua = {
      ['=='] = '~=',
    },
    jslike = {
      ['==='] = '!==',
    },
  },
}
```

## TODO

[x] Invert token under cursor
  [ ] Handle tokens with similar starts (e.g. `==` and `===`)
[ ] Batch inversion mode

## Inspiration

[nvim-toggler](https://github.com/nguyenvukhang/nvim-toggler) for the core concept
[nvim-treehopper](https://github.com/mfussenegger/nvim-treehopper) for the batch inversion UI
