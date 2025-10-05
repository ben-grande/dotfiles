#!/usr/bin/env zsh

## SPDX-FileCopyrightText: 2004 - 2022 Tim Pope <https://tpo.pe>
## SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>
##
## SPDX-License-Identifier: AGPL-3.0-or-later

## Credits: https://github.com/tpope/dotfiles/blob/master/.zshrc

## {{{ Requirements
## If not running interactively, return.
case $- in
  *i*) ;;
    *) return;;
esac

## Source default files.
# shellcheck disable=SC1090
source "$HOME/.zprofile"
source "$ENV"
## }}}
## {{{ Options
PROMPT_EOL_MARK='%b%B%S%#%s%b'
## - Quiet
setopt no_beep
## - Words
setopt interactive_comments
## - History
SAVEHIST="$HISTSIZE"
setopt no_extended_history
setopt hist_expire_dups_first # purge dups first
setopt hist_ignore_dups # ignore dups in history list
setopt hist_verify # if command has hist expansion, show it before executing
setopt inc_append_history # append command to history as soon as it runs
## - Expansion
setopt auto_cd
setopt no_nomatch # if a pattern has no matches print an error
setopt numeric_glob_sort # sort file names numerically when relevant
setopt magic_equal_subst # filename expansion for opt=arg
setopt no_equals # don't interpret =string as a command
## - Prompt
setopt prompt_subst
setopt transient_rprompt
setopt print_exit_value

if test "${color_prompt-}" = "yes"; then
  set zle_bracketed_paste
  autoload -Uz bracketed-paste-magic
  zle -N bracketed-paste bracketed-paste-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic
  }
  pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
  }
  zstyle :bracketed-paste-magic paste-init pasteinit
  zstyle :bracketed-paste-magic paste-finish pastefinish
else
  unset zle_bracketed_paste
fi

## }}}
## {{{ Alias
alias reload="exec zsh"
## }}}
## {{{ Prompt

newline=$'\n'
if test "${color_prompt-}" = "yes"; then
  autoload -U colors && colors
  [[ "${COLORTERM-}" == (24bit|truecolor) ||
    "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

  PS1="\$(resize-terminal)%F{magenta}[%{${usercolor}%}%n@%m%F{reset_color%}"
  PS1="${PS1} %{$dircolor%}%50<...<%~%<<%F{reset_color%}\$(_git_prompt_info)"
  PS1="${PS1}%F{magenta}]%F{reset_color}${newline-}${ps1_symbol} "
  RPS1="%(?..(%F{red%}%?%F{reset_color%}%)%<<)"
else
  PS1="\$(resize-terminal)[%n@%M %~\$(_git_prompt_info)]${newline}"
  PS1="${PS1}${ps1_symbol} "
  RPS1="%(?..(%?%)%<<)"
fi

## Set window title
_set_title() {
  case "${1:-}" in
    *install*)
      hash -r ;;
  esac
  print -Pn '\033]1;%l@%m${1+*}\a'
  print -Pn '\033]2;%n@%m:%~'
  if test -n "${1:-}"; then
    print -Pnr ' (%24>..>$1%>>)' | tr '\0-\037' '?'
  fi
  print -Pn " [%l]\a"
}

case "${TERM-}" in
  screen*|tmux*)
    precmd() {
      _set_title "$@"
      if [ "${STY:-}" -o "${TMUX:-}" ]; then
        print -Pn '\033k@\033\\'
      else
        print -Pn '\033k@%m\033\\'
      fi
    }
    preexec() {
      _set_title "$@"
      return 0
      #print -Pnr '%10>..>$1' | tr '\0-\037' '?'
      #if [ "${STY:-}" -o "${TMUX:-}" ]; then
      #  print -Pn '\033k@\033\\'
      #else
      #  print -Pn '\033k@%m\033\\'
      #fi
    }
  ;;

  *?-direct*|xterm*|rxvt*|Eterm*|kterm*|putty*|dtterm*|ansi*|cygwin*)
    precmd () { _set_title "$@" }
    preexec() { _set_title "$@" }
    ;;

  ""|dumb|linux*|vt220*|vt100*) ;;

  *)
    PS1="%n@%m:%~%# "
    RPS1="%(?..(%?%)%<<)"
    ;;
esac

unset hostcolor hostletter hostcode dircolor usercolor usercode newline \
      ps1_symbol
## }}}
## {{{ Completions

## Enable completion.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path \
  "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompcache
zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-prompt \
  %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'r:|[-_.]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt \
  %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:-command-:*:*' file-patterns \
  '*(#q-*):executables:Executables *(-/):directories:Directories'
zstyle -e ':completion:*:*:-command-:*:*' tag-order '
  reply=("
    executables:Executables:Executables
    builtins:Builtins:Builtins
    commands:Commands:Commands
    aliases:Aliases:Aliases
    functions:Functions:Functions
    parameters:Variables:Variables
    reserved-words:Keywords:Keywords
    directories:Directories
    " -
  )'

## Completion per utility.
zstyle ':completion:*:sudo::' environ \
  HOME="/root" \
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
zstyle ':completion:*:doas::' environ \
  HOME="/root" \
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

## Colored completions.
# zstyle ':completion:*' format 'Completing %d'
if test "${color_prompt-}" = "yes"; then
  zstyle ':completion:*:*:*:*:descriptions' format '%B%F{blue}-- %d --%b%f'
  zstyle ':completion:*:messages' format ' %B%F{purple} -- %d --%f%b'
  zstyle ':completion:*:warnings' format ' %B%F{red}-- no matches --%f%b'

  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:*:kill:*' list-colors \
    '=(#b) #([0-9]#)*( *[a-z])*=94=91=93'
else
  zstyle ':completion:*:*:*:*:descriptions' format '-- %d --%b%f'
  zstyle ':completion:*:messages' format ' -- %d --%f%b'
  zstyle ':completion:*:warnings' format ' -- no matches --%f%b'

  zstyle ':completion:*:default' list-colors ''
  zstyle ':completion:*:*:kill:*' list-colors ''
fi

## Load completions.
autoload -Uz compinit
zmodload zsh/complist
mkdir -p -- "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
# _comp_options+=(globdots)
! has zoxide || eval "$(zoxide init zsh)"
! has gitlint || eval "$(_GITLINT_COMPLETE=zsh_source gitlint)"
## }}}
## {{{ Plugins
source_readable /usr/share/doc/fzf/examples/key-bindings.zsh
source_readable /usr/share/doc/fzf/examples/completion.zsh

if test "${color_prompt-}" = "yes"; then
  ## Enable auto-suggestions based on the history
  if test -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; then
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="standout"
    typeset -a ZSH_AUTOSUGGEST_CLEAR_WIDGETS
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi
  ## Highlight commands as you type
  if test -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  then
    ## https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
    ZSH_HIGHLIGHT_STYLES[command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
    typeset -A ZSH_HIGHLIGHT_REGEXP
    ZSH_HIGHLIGHT_REGEXP+=('^sudo' 'fg=magenta')
    ZSH_HIGHLIGHT_REGEXP+=('^doas' 'fg=magenta')
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
fi
## }}}
## {{{ Bindkeys

## Widgets
##
function bindkey-multi () {
  ## Usage: bindkey-multi mode Nmode -- bind nbind terminfoname -- widgetname
  local i j widget nomap
  local -a maps sequences

  test "$1" = "--" && nomap=1

  while [[ "$1" != "--" ]]; do
    maps+=( "$1" )
    shift
  done
  shift

  while [[ "$1" != "--" ]]; do
    sequences+=( "$1" )
    shift
  done
  shift

  widget="$1"
  test -z "$widget" && return 1

  if test -n "$nomap"; then
    for j in "${sequences[@]}"; do
      test "$j" || continue
      bindkey -- "$j" "$widget"
    done
    return 0
  fi

  for i in "${maps[@]}"; do
    test "$i" || continue
    for j in "${sequences[@]}"; do
      test "$j" || continue
      bindkey -M "$i" -- "$j" "$widget"
    done
  done
  return 0
}

function clear-screen-and-scrollback() {
  case "${TERM-}" in
    ""|dumb|linux*|vt100*|vt220*) return;;
  esac
  test -n "${TTY-}" || return
  echoti civis >"${TTY-}"
  printf '%b' "\033[H\033[2J" >"${TTY-}"
  zle .reset-prompt
  zle -R
  printf '%b' "\033[3J" >"${TTY-}"
  echoti cnorm >"${TTY-}"
}
zle -N clear-screen-and-scrollback

fg-widget() {
  if [[ $#BUFFER -eq 0 ]]; then
    if jobs %- >/dev/null 2>&1; then
      BUFFER='fg %-'
    else
      BUFFER='fg'
    fi
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fg-widget

change-first-word(){
  zle beginning-of-line -N
  zle kill-word
}
zle -N change-first-word

new-screen() {
  test -z "${STY-}" || screen < "${TTY-}"
  test -z "${TMUX-}" || tmux new-window
}
zle -N new-screen

case "${TERM-}" in
  ""|dumb|linux*|vt100*|vt220*) ;;
  *)
    zle-keymap-select zle-line-init() {
      case "${KEYMAP:-}" in
        vicmd)      print -n -- "\033[2 q";;
        viins|main) print -n -- "\033[5 q";;
      esac

      zle reset-prompt
      zle -R
    }

    zle-line-finish() {
      print -n -- "\033[2 q"
    }

    zle -N zle-line-init
    zle -N zle-line-finish
    zle -N zle-keymap-select
    ;;
esac

set-keymap-vi(){
  export KEYTIMEOUT=1
  bindkey -v
}

set-keymap-emacs(){
  bindkey -e
  bindkey -r "^Q"
}

## Keymap mode
set-keymap-emacs

autoload -Uz select-word-style
select-word-style bash

## Viins
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^B" backward-char
bindkey -M viins "^D" delete-char-or-list
bindkey -M viins "^E" end-of-line
bindkey -M viins "^F" forward-char
bindkey-multi emacs viins vicmd -- "^G" -- which-command
bindkey -M viins "^J" accept-search
bindkey -M viins "^K" kill-line
bindkey -M viins "^L" clear-screen-and-scrollback
bindkey -M viins "^M" accept-line
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^S" history-incremental-search-forward
bindkey -M viins "^T" transpose-chars
bindkey-multi emacs viins -- "^W" -- vi-backward-kill-word
bindkey -M viins "^U" backward-kill-line
bindkey -M emacs "^U" backward-kill-line
bindkey -M viins "^Y" yank
bindkey-multi emacs viins vicmd -- "^Z" -- fg-widget
bindkey -M viins "^_" undo
bindkey -M viins "^@" redo
bindkey -M viins " " magic-space
bindkey -M emacs " " magic-space
bindkey -M emacs "^X^[" vi-cmd-mode
## Viins alt
bindkey -M viins "^[u" undo
bindkey -M viins "^[r" redo
bindkey -M viins "^[m" copy-prev-shell-word

## Misc
bindkey -M isearch "^J" accept-search 2>/dev/null
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "^C" send-break
bindkey -M menuselect "^J" accept-and-infer-next-history # accept-search
bindkey -M menuselect "^M" accept-line

## Keys for multiple modes and multiple bindings.
## https://invisible-island.net/xterm/xterm-function-keys.html
##
## Shit+Tab
bindkey-multi emacs viins menuselect -- "\033[Z" "${terminfo[kcbt]}" \
  -- reverse-menu-complete
## Backspace
bindkey-multi emacs viins vicmd menuselect -- "^H" "^?" "${terminfo[kbs]}" \
  -- backward-delete-char
## Home
bindkey-multi emacs viins vicmd -- "\033[1~" "\033[7~" "\033[H" "\033OH" \
  "${terminfo[khome]}" \
  -- beginning-of-line
## Insert
bindkey-multi emacs viins vicmd -- "\033[2~" "\033[L" "${terminfo[kich1]}" \
  -- overwrite-mode
## Delete
bindkey-multi emacs viins vicmd -- "\033[3~" "\033[P" "\033OP" \
  "${terminfo[kdch1]}" \
  -- vi-delete-char
## End
bindkey-multi emacs viins vicmd -- "\033[4~" "\033[8~" "\033[F" "\033OF" \
  "${terminfo[kend]}" \
  -- end-of-line
## PgUp
bindkey-multi emacs viins -- "\033[5~" "\033[I" "${terminfo[kpp]}" \
  -- beginning-of-buffer-or-history
## PgDown
bindkey-multi emacs viins -- "\033[6~" "\033[G" "${terminfo[knp]}" \
  -- end-of-buffer-or-history
## Up arrow
bindkey-multi emacs viins vicmd -- "\033[A" "\033OA" "${terminfo[kcuu1]}" \
  -- up-line-or-history
## Down arrow
bindkey-multi emacs viins vicmd -- "\033[B" "\033OB" "${terminfo[kcud1]}" \
  -- down-line-or-history
## Right arrow
bindkey-multi emacs viins vicmd -- "\033[1C" "\033[C" "\033OC" \
  "${terminfo[kcuf1]}" \
  -- forward-char
## Left arrow
bindkey-multi emacs viins vicmd -- "\033[D" "\033OD" "${terminfo[kcub1]}" \
  -- backward-char
## Ctrl-Delete
bindkey-multi emacs viins vicmd -- "\033[3;5~" "\033[3\^" "${terminfo[kDC5]}"  \
  -- kill-word
## Ctrl-RightArrow
bindkey-multi emacs viins vicmd -- "\033[1;5C" "\0330c" "${terminfo[kRIT5]}" \
  -- forward-word
## Ctrl-LeftArrow
bindkey-multi emacs viins vicmd -- "\033[1;5D" "\0330d" "${terminfo[kLFT5]}" \
  -- backward-word
## F11
bindkey-multi emacs viins -- "\033[23~" "${terminfo[kf11]}" -- new-screen

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs "^[e" edit-command-line
bindkey -M emacs "^X^E" edit-command-line
bindkey -M vicmd "^E" edit-command-line

bindkey -M emacs "\033a" change-first-word
bindkey -M emacs "^XD" describe-key-briefly

for binding in ${(f)$(bindkey -M emacs|grep -e '^"\^X')}; do
  bindkey -M viins "${(@Qz)binding}"
done
unset binding

## Make sure the terminal is in application mode, when zle is active.
## Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
## }}}
## {{{ End
## Source local zsh configuration.
source_readable "$HOME/.zshrc.local"
## }}}
