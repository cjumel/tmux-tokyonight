#!/usr/bin/env bash

# TokyoNight colors for Tmux
# Plugin structure is inspired by https://github.com/rose-pine/tmux

export CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
	local option value default
	option="$1"
	default="$2"
	value="$(tmux show-option -gqv "$option")"

	if [ -n "$value" ]; then
		echo "$value"
	else
		echo "$default"
	fi
}

set() {
	local option=$1
	local value=$2
	tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
	local option=$1
	local value=$2
	tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

unset_option() {
	local option=$1
	local value=$2
	tmux_commands+=(set-option -gu "$option" ";")
}

main() {
	local theme
	theme="$(get_tmux_option "@tokyonight_theme" "night")"

	if [[ $theme == night ]]; then

		blue="#7aa2f7"
		black="#15161e"
		yellow="#e0af68"
		fg_gutter="#3b4261"
		fg_sidebar="#a9b1d6"
		bg_statusline="#16161e"

	elif [[ $theme == moon ]]; then

		blue="#82aaff"
		black="#1b1d2b"
		yellow="#ffc777"
		fg_gutter="#3b4261"
		fg_sidebar="#828bb8"
		bg_statusline="#1e2030"

	elif [[ $theme == storm ]]; then

		blue="#7aa2f7"
		black="#1d202f"
		yellow="#e0af68"
		fg_gutter="#3b4261"
		fg_sidebar="#a9b1d6"
		bg_statusline="#1f2335"

	elif [[ $theme == day ]]; then

		blue="#2e7de9"
		black="#e9e9ed"
		yellow="#8c6c3e"
		fg_gutter="#a8aecb"
		fg_sidebar="#6172b0"
		bg_statusline="#e9e9ec"

	fi

	none="NONE"

	# Aggregating all commands into a single array
	local tmux_commands=()

	# Initial options are taken from https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/extra/tmux.lua

	set mode-style "fg=${blue},bg=${fg_gutter}"

	set message-style "fg=${blue},bg=${fg_gutter}"
	set message-command-style "fg=${blue},bg=${fg_gutter}"

	set pane-border-style "fg=${fg_gutter}"
	set pane-active-border-style "fg=${blue}"

	set status "on"
	set status-justify "left"

	set status-style "fg=${blue},bg=${bg_statusline}"

	set status-left-length "100"
	set status-right-length "100"

	set status-left-style ${none}
	set status-right-style ${none}

	set status-left "#[fg=${black},bg=${blue},bold] #S #[fg=${blue},bg=${bg_statusline},nobold,nounderscore,noitalics]"
	set status-right "#[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]#[fg=${blue},bg=${bg_statusline}] #{prefix_highlight} #[fg=${fg_gutter},bg=${bg_statusline},nobold,nounderscore,noitalics]#[fg=${blue},bg=${fg_gutter}] #W  #h #[fg=${blue},bg=${fg_gutter},nobold,nounderscore,noitalics]#[fg=${black},bg=${blue},bold] %H:%M "

	setw window-status-activity-style "underscore,fg=${fg_sidebar},bg=${bg_statusline}"
	setw window-status-separator ""
	setw window-status-style "${none},fg=${fg_sidebar},bg=${bg_statusline}"
	setw window-status-format "#[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]#[default] #I  #{b:pane_current_path} #F #[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]"
	setw window-status-current-format "#[fg=${bg_statusline},bg=${fg_gutter},nobold,nounderscore,noitalics]#[fg=${blue},bg=${fg_gutter},bold] #I  #{b:pane_current_path} #F #[fg=${fg_gutter},bg=${bg_statusline},nobold,nounderscore,noitalics]"

	# Call everything to action
	tmux "${tmux_commands[@]}"
}

main "$@"
