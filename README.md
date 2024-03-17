<a name="readme-top"></a>

<!-- sields -->
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<h3 align="center">neovim-pax</h3>

<div>
  <p align="center">
    Minimal Neovim configuration you can be at peace with.
    <br />
    <br />
    <a href="https://github.com/straightchlorine/neovim-pax/issues">Report Bug</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#personalization">Personalization</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#alternatives">Alternatives</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
<a name="about"></a>
## About

Pax is a simple and extensive Neovim configuration.

[![neovim-pax][product-screenshot]](https://example.com)
[![neovim-pax][product-screenshot-writing]](https://example.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="getting-started"></a>
<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
<a name="prerequisites"></a>
* Ensure that you have [neovim-nightly](https://github.com/neovim/neovim/tree/nightly) installed.
* Configuration of language servers can be found in`lua/configuration/lsp.lua` file. In order to utilise their
functionality, you need to install them on your system. The process for each supported language server
is extensively covered in [nvim-lspconfig documentation](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
(you can also access it locall via `:h lspconfig-server-configurations`).

<a name="installation"></a>
### Installation

To use the configuration you just need to clone this repository into `~/.config/nvim` directory:
   ```sh
   git clone https://github.com/straightchlorine/neovim-pax.git ~/.config/nvim
   ```

<a name="personalization"></a>
### Personalization

Each file has a small comment at the top explaining it's function, it makes it pretty easy to find what needs to be changed.
```
--- lsp.lua
-- Configuration for nvim-lspconfig.
---
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Roadmap -->
<a name="roadmap"></a>
## Roadmap

- [ ] Expand documentation.
- [ ] Simplify the configuration by further modularization.
- [ ] Deal with some of the hardcoded variables.
- [ ] Clear out duplicate mappings.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Contributing -->
<a name="contributing"></a>
## Contributing

Project is open for suggestions and fixes, which you can propose via issues or pull requests.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- License -->
<a name="license"></a>
## License

Distributed under the GPL-3.0 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Alternatives -->
<a name="alternatives"></a>
## Alternatives

Project is still in progress and will most likely be for a long time. It also has not been extensively tested,
thus problems might occur not only because of various plugins and settings, but also due to the dynamic nature 
of [neovim-nightly](https://github.com/neovim/neovim/tree/nightly) release.

If that is not what you are looking for, I recommend the following:

* [NvChad](https://github.com/NvChad/NvChad)
* [LazyVim](https://github.com/LazyVim/LazyVim)

These configurations are very beatiful, fast and with minimal effort will provide everything 
my configuration does and will do it better.

If you do not fancy maintaining your own configuration, I definitely recommend trying them out.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-url]: https://github.com/straightchlorine/neovim-pax/blob/master/LICENSE
[linkedin-url]: https://www.linkedin.com/in/straightchlorine/
[issues-url]: https://github.com/straightchlorine/neovim-pax/issues

[issues-shield]: https://img.shields.io/github/issues/straightchlorine/neovim-pax.svg?style=for-the-badge
[license-shield]: https://img.shields.io/github/license/straightchlorine/neovim-pax.svg?style=for-the-badge
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[product-screenshot]: img/preview-nvim-dashboard.png
[product-screenshot-writing]: img/preview-nvim-writing.png
