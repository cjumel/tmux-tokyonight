#!/usr/bin/env bash

# TokyoNight colors for Tmux
# Plugin structure is inspired by https://github.com/rose-pine/tmux

export CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPTS_PATH="$CURRENT_DIR/scripts"

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

    # Colors can be seen in https://github.com/folke/tokyonight.nvim/tree/main/extras/lua
    if [[ $theme == night ]]; then

        bg_highlight="#292e42"
        bg_statusline="#16161e"
        black="#15161e"
        blue="#7aa2f7"
        fg="#c0caf5"
        fg_gutter="#3b4261"
        fg_sidebar="#a9b1d6"
        green="#9ece6a"
        yellow="#e0af68"

    elif [[ $theme == moon ]]; then

        bg_highlight="#2f334d"
        bg_statusline="#1e2030"
        black="#1b1d2b"
        blue="#82aaff"
        fg="#c8d3f5"
        fg_gutter="#3b4261"
        fg_sidebar="#828bb8"
        green="#c3e88d"
        yellow="#ffc777"

    elif [[ $theme == storm ]]; then

        bg_highlight="#292e42"
        bg_statusline="#1f2335"
        black="#1d202f"
        blue="#7aa2f7"
        fg="#c0caf5"
        fg_gutter="#3b4261"
        fg_sidebar="#a9b1d6"
        green="#9ece6a"
        yellow="#e0af68"

    elif [[ $theme == day ]]; then

        bg_highlight="#c4c8da"
        bg_statusline="#d0d5e3",
        black="#b4b5b9",
        blue="#2e7de9"
        fg="#3760bf"
        fg_gutter="#a8aecb"
        fg_sidebar="#6172b0"
        green="#587539"
        yellow="#8c6c3e"

    fi

    none="NONE"

    # Icons found in nerd-font
    terminal_icon=""
    terminal_icon_active=""
    terminal_icon_last="󰁯"

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

    set status-style "fg=${fg_sidebar},bg=${bg_statusline}"

    set status-left-length "100"
    set status-right-length "100"

    set status-left-style ${none}
    set status-right-style ${none}

    set status-left "#[fg=${black},bg=${blue},bold] #{?client_prefix,󰠠 ,#[dim]󰤂 }#[bold,nodim]#S "
    set status-right "#[fg=${fg_sibebar},bg=${bg_statusline}] #{user}  #h  %H:%M "

    setw window-status-activity-style "underscore,fg=${fg_sidebar},bg=${bg_statusline}"
    setw window-status-separator ""
    setw window-status-style "${none},fg=${fg_sidebar},bg=${bg_statusline}"

    window_icon="#{?window_last_flag,#[fg=${yellow}]${terminal_icon_last}#[fg=${fg_sidebar}],${terminal_icon}}"
    window_icon_current="#[fg=${green}]${terminal_icon_active}#[fg=${fg}]"
    window_number="#($SCRIPTS_PATH/custom-number.sh #I dsquare)"
    window_text="#W"

    setw window-status-format "#[default] $window_icon $window_text $window_number  "
    setw window-status-current-format "#[fg=${fg},bg=${bg_highlight}] $window_icon_current $window_text $window_number  "

    # Call everything to action
    tmux "${tmux_commands[@]}"
}

main "$@"
