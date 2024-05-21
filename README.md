# Tmux-Tokyonight

A simple plugin for Tmux, inspired by the
[tokyonight.nvim Neovim theme](https://github.com/folke/tokyonight.nvim), which is itself inspired
by the [Visual Studio Code TokyoNight theme](https://github.com/enkia/tokyo-night-vscode-theme).

This plugin borrows some code from:

- the [rose-pine Tmux plugin](https://github.com/rose-pine/tmux), for the simple mono-file plugin
  structure and utilities
- the [tokyonight.nvim Neovim theme](https://github.com/folke/tokyonight.nvim) for the colors and
  the initial status line structure
- the [Catppuccin Tmux plugin](https://github.com/catppuccin/tmux)
  [tokyo-night-tmux Tmux plugin](https://github.com/janoamaral/tokyo-night-tmux) for additional
  customization

## Usage

1. Install [TPM](https://github.com/tmux-plugins/tpm)

2. Add the Tokyonight plugin with the following line in your Tmux configuration file:

   ```tmux
     set -g @plugin 'clementjumel/tmux-tokyonight'
     set -g @tokyonight_theme 'night' # or 'moon', 'storm', 'day'
     ... 
     set -g @plugin 'tmux-plugins/tpm'
   ```

3. To install the plugin when using it for the first time, restart Tmux and use the `prefix + I`
   (capital I) combination to source your configuration. For updating the plugin, the key
   combination is `prefix + U` (capital U).
