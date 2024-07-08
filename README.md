<a name="readme-top"></a>

<!-- sields -->
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<h3 align="center">neovim-pax</h3>

<div>
  <p align="center">
    Rewritten and modernised minimal Neovim configuration you can be at peace with.
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

Pax is a very modularised and extensive Neovim configuration, that have been modernised
and completely rewritten to catch up with new functionalities that previous versions
were missing out on.

[![neovim-pax][product-screenshot]](https://example.com)
[![neovim-pax][product-screenshot-writing]](https://example.com)

#### Features
* packages managed by [lazy.nvim](https://github.com/folke/lazy.nvim);
* simplified software management provided by [Mason](https://github.com/williamboman/mason.nvim);
* full debugging support thanks to [nvim-dap](https://github.com/mfussenegger/nvim-dap) and [neotest](https://github.com/nvim-neotest/neotest);
* a total of 80 plugins aimed to provide support for many technologies and enable a seamless, productive and efficient workflow.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="getting-started"></a>
<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
<a name="prerequisites"></a>
* Ensure that you have [neovim](https://github.com/neovim/neovim) installed.

<a name="installation"></a>
### Installation

To use the configuration you just need to clone this repository into `~/.config/nvim` directory:
   ```sh
   git clone https://github.com/straightchlorine/neovim-pax.git ~/.config/nvim
   ```

Now it's ready, you can add LSPs as well as other tools using `:MasonInstall <tool>`, so that the configuration fits your needs.

## Roadmap

- [ ] Expand documentation.
- [ ] Simplify the configuration.
- [x] Deal with some of the hardcoded variables.
- [x] Clear out duplicate mappings.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Contributing -->
<a name="contributing"></a>
## Contributing

Project is open for suggestions and fixes, which you can propose through issues or pull requests.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- License -->
<a name="license"></a>
## License

Distributed under the GPL-3.0 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Alternatives -->
<a name="alternatives"></a>
## Alternatives

Project is still in progress and will most likely be for a long time. Thus, if what you need is stability
and the very same functionality (possibly much more), following would be recommend:

* [NvChad](https://github.com/NvChad/NvChad)
* [LazyVim](https://github.com/LazyVim/LazyVim)

These configurations are stunning, fast and will provide everything you need -- long term stability as 
the most up to date functionalities you might want.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-url]: https://github.com/straightchlorine/neovim-pax/blob/master/LICENSE
[linkedin-url]: https://www.linkedin.com/in/straightchlorine/
[issues-url]: https://github.com/straightchlorine/neovim-pax/issues

[issues-shield]: https://img.shields.io/github/issues/straightchlorine/neovim-pax.svg?style=for-the-badge
[license-shield]: https://img.shields.io/github/license/straightchlorine/neovim-pax.svg?style=for-the-badge
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[product-screenshot]: img/preview-nvim.png
[product-screenshot-writing]: img/preview-nvim-writing.png
