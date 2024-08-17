# SimpleClaudia

SimpleClaudia is a minimalist and elegant color scheme for Neovim, designed to provide a comfortable and distraction-free coding experience. It offers both light and dark themes, with carefully chosen colors to enhance readability and reduce eye strain.

**Note: SimpleClaudia is currently in alpha. Expect frequent updates and potential breaking changes.**

## Theme Preview

### Light Theme
<img width="1491" alt="image" src="https://github.com/user-attachments/assets/8be3d8db-2bc8-4147-abe0-737b9a0a8c12">

### Dark Theme
<img width="1491" alt="image" src="https://github.com/user-attachments/assets/937d20b6-cfe4-4f2b-ac76-4e36af7c4339">

## Features

- Light and dark themes
- Carefully chosen colors for optimal readability
- Support for popular plugins and language syntax
- Easy toggling between light and dark modes
- Development mode for real-time updates while customizing

## Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

Add the following line to your Neovim configuration:

```lua
use {
  'guilhermeprokisch/simpleclaudia',
  config = function()
    require('simpleclaudia.setup').setup()
  end
}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your Neovim configuration:

```lua
{
  'guilhermeprokisch/simpleclaudia',
  config = function()
    require('simpleclaudia.setup').setup()
  end
}
```

## Usage

After installation, you can set SimpleClaudia as your color scheme:

```lua
vim.cmd('colorscheme simpleclaudia')
```

To toggle between light and dark modes:

```vim
:SimpleClaudiaToggle
```

To enter development mode (for customizing the color scheme):

```vim
:SimpleClaudiaDev
```

## Customization

SimpleClaudia is designed to be easily customizable. You can modify the colors in the `lua/simpleclaudia/init.lua` file. When in development mode, changes will be applied in real-time upon saving the file.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Special thanks to the Neovim community for their invaluable resources and inspiration.

