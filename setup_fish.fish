set -U fish_greeting
set -U fish_prompt_pwd_dir_length 0

set -U EDITOR /usr/bin/nvim

# used for coloring
set default (tput sgr0)
set red (tput setaf 1)
set green (tput setaf 2)
set purple (tput setaf 5)
set orange (tput setaf 9)

# Less colors for man pages
set -U PAGER less
# Begin blinking
set -U LESS_TERMCAP_mb $red
# Begin bold
set -U LESS_TERMCAP_md $orange
# End mode
set -U LESS_TERMCAP_me $default
# End standout-mode
set -U LESS_TERMCAP_se $default
# Begin standout-mode - info box
set -U LESS_TERMCAP_so $purple
# End underline
set -U LESS_TERMCAP_ue $default
# Begin underline
set -U LESS_TERMCAP_us $green
