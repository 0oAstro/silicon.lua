# silicon.lua

**silicon** is a lua plugin for neovim to generate beautiful images of code snippet using [silicon](https://github.com/aloxaf/silicon) 

<video src = "https://user-images.githubusercontent.com/79555780/198016165-7a47ac6c-e329-4025-8d66-f9b34bd52658.mp4"></video>

## ✨ Features

- **beautiful** images of source code, saved to preferred place.
- **copy** to clipboard

## ⚡️ Requirements

- Neovim >= 0.6.0

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
-- Lua
use {
  "narutoxy/silicon.lua",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require('silicon').setup({})
  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
" Vim Script
Plug 'nvim-lua/plenary.nvim'
Plug 'narutoxy/silicon.lua'

lua require('silicon').setup({})
```

## ⚙️ Configuratioon

silicon comes with the following defaults:

```lua
{
	theme = "Dracula",
	output = string.format(
		"SILICON_%s-%s-%s_%s-%s.png",
		os.date("%Y"),
		os.date("%m"),
		os.date("%d"),
		os.date("%H"),
		os.date("%M")
	), -- auto generate file name based on time (absolute or relative to cwd)
	bgColor = vim.g.terminal_color_5,
	bgImage = "", -- path to image, must be png
	roundCorner = true,
	windowControls = true,
	lineNumber = true,
	font = "monospace",
	lineOffset = 1, -- from where to start line number
	linePad = 2, -- padding between lines
	padHoriz = 80, -- Horizontal padding
	padVert = 100, -- vertical padding
	shadowBlurRadius = 10,
	shadowColor = "#555555",
	shadowOffsetX = 8,
	shadowOffsetY = 8,

}
```
