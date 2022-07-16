if status is-interactive
  set fish_greeting

  set -gx TERM xterm-256color

  # theme
  set -g theme_color_scheme terminal-dark
  set -g fish_prompt_pwd_dir_length 1
  set -g theme_display_user yes
  set -g theme_hide_hostname no
  set -g theme_hostname always

  # aliases
  alias ls "exa --icons"
  alias ll "exa -l -g -a --icons"
  alias lt "exa --tree --icons -l -g"
  alias mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
  alias mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
  alias mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
  alias mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
  alias grep "grep --color=always"
  alias egrep "egrep --color=always"
  alias cp "cp -i"
  alias mv "mv -i"
  alias rm "rm -i"
  alias disk "df -h"
  alias sysctl "systemctl list-unit-files --state=enabled"

  set -gx EDITOR vsn

  set -gx PATH bin $PATH
  set -gx PATH $HOME/bin $PATH
  set -gx PATH $HOME/.local/bin $PATH

  # NodeJS
  set -gx PATH node_modules/.bin $PATH

  # Go
  set -g GOPATH $HOME/go
  set -gx PATH $GOPATH/bin $PATH

  # prompt
  set -g cyan (set_color -o cyan)
  set -g yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -g green (set_color -o green)
  set -g purple (set_color -o purple)
  set -g normal (set_color normal)

  set -g whitespace " "

  set -g __fish_git_prompt_show_informative_status 1
  set -g __fish_git_prompt_hide_untrackedfiles 1

  set __fish_git_prompt_showdirtystate "yes"
  set __fish_git_prompt_showstashstate "yes"
  set __fish_git_prompt_showuntrackedfiles "yes"
  set __fish_git_prompt_showupstream "yes"
  set __fish_git_prompt_color_branch purple
  set __fish_git_prompt_color red
  set __fish_git_prompt_char_stateseparator ""
  set __fish_git_prompt_char_dirtystate "U"
  set __fish_git_prompt_char_stagedstate "S"
  set __fish_git_prompt_char_untrackedfiles "!"
  set __fish_git_prompt_char_stashstate "B"
  set __fish_git_prompt_char_upstream_ahead "!"
  set __fish_git_prompt_char_upstream_behind "U"
  set __fish_git_prompt_char_cleanstate ""
  set __fish_git_prompt_color_prefix blue
  set __fish_git_prompt_color_suffix blue

  function fish_prompt
    set last_status $status
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    if test -e package.json
      set node_prompt $green " ⬢ (node)"
    end

    if test $last_status = 0
      set initial_indicator $blue"[$normal$USER$red@$normal$hostname$blue]"
      set status_indicator "$normal❯$cyan❯$green❯$purple❯"
    else
      set initial_indicator $blue"[$normal$USER$red@$normal$hostname$blue]"
      set status_indicator "$red❯$red❯$red❯$red❯"
    end
    if set -q VIRTUAL_ENV
      set venv $whitespace (set_color yellow) " (" (basename "$VIRTUAL_ENV") (set_color yellow) ")"
    end

    printf "%s%s%s%s%s%s%s%s%s" $initial_indicator $whitespace $cyan(basename (prompt_pwd)) $(__fish_git_prompt) $venv $node_prompt $whitespace $status_indicator $whitespace

  end

end
