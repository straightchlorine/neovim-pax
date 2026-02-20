<a name="readme-top"></a>

<h3 align="center">neovim-pax</h3>

<div>
  <p align="center">
    Minimal Neovim configuration you can be at peace with.
    <br />
  </p>
</div>

## About

**Repository:** [Codeberg](https://codeberg.org/piotrkrzysztof/cloud) (primary) ·
[GitHub](https://github.com/straightchlorine/cloud) (mirror)

Pax is a modularised and extensive Neovim configuration.

Currently it has **65** plugins, providing support for a vast array of technologies.
The goal is to keep reducing the number of plugins and to replace them with Neovim-native solutions.

[![neovim-pax][product-screenshot]](https://example.com)
[![neovim-pax][product-screenshot-writing]](https://example.com)

#### Features

Configuration takes advantage of a considerable number of plugins. Most notable ones are:

* packages managed by [lazy.nvim](https://github.com/folke/lazy.nvim);
* debugging support for Golang, C++, Python and Rust (via [nvim-dap](https://github.com/mfussenegger/nvim-dap), [dap-ui](https://github.com/rcarriga/nvim-dap-ui) and [neotest](https://github.com/nvim-neotest/neotest);
* extensive usage of [snacks.nvim](https://github.com/folke/snacks.nvim) and [mini.nvim](https://github.com/nvim-mini/mini.nvim) for QoL improvements;
* support for session saving via [posession](https://github.com/jedrzejboczar/possession.nvim);
* support for typescript via [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim);
* support for LaTeX via [vimtex](https://github.com/lervag/vimtex);


## Getting Started

### Prerequisites
* Ensure that you have [neovim](https://github.com/neovim/neovim) installed.

### Installation

To use the configuration you just need to clone this repository into `~/.config/nvim` directory:
   ```sh
   git clone https://github.com/straightchlorine/neovim-pax.git ~/.config/nvim
   ```

Now it's ready, you can add LSPs as well as other tools using `:MasonInstall <tool>`, so that the configuration fits your needs.

## Alternatives

It's just my private configuration. If what you need is stability, following would be recomended:

* [NvChad](https://github.com/NvChad/NvChad)
* [LazyVim](https://github.com/LazyVim/LazyVim)

These configurations are fast, well documented and maintained.

[product-screenshot]: img/preview-nvim.png
[product-screenshot-writing]: img/preview-nvim-writing.png
