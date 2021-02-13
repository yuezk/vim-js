# vim-js

A Vim syntax highlighting plugin for JavaScript and [Flow.js](https://flow.org/)

## Pros.

- Better support for modern JavaScript features ([decorators](https://github.com/tc39/proposal-decorators), [private members](https://github.com/tc39/proposal-private-methods), [numeric separators](https://github.com/tc39/proposal-numeric-separator), [optional chaining](https://github.com/tc39/proposal-nullish-coalescing), etc.)
- Better support for [Flow.js](https://flow.org/) syntax
- Better support for [JSDoc](https://jsdoc.app/) syntax
- More accurate syntax groups, for easy colorscheme customization

<img src="https://github.com/yuezk/vim-js/raw/3c69f3e3a2d2d9712dcc9c79b57dbff55a8455a6/screenshot.png" alt="yuezk/vim-js screenshot" width="694">

## Install

1. Choose your favourite plugin manager (e.g. [vim-plug](https://github.com/junegunn/vim-plug))
1. Install it with `Plug 'yuezk/vim-js'`

## Highlight JSX Syntax

Please use [vim-jsx-pretty](https://github.com/MaxMEllon/vim-jsx-pretty) to highlight the JSX syntax. It's another plugin I currently maintain.

```vim
Plug 'maxmellon/vim-jsx-pretty'
```

## License

[MIT License](LICENSE)
