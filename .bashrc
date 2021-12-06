# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias dir="command ls -l -h"
alias ls="ls -h --color --group-directories-first"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias fd="fd-find"
alias free="free -hw"
alias cd..="cd .."
alias ..="cd .."

# Powerline
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

# added by pipx (https://github.com/pipxproject/pipx)
export PATH="/home/hstde/.local/bin:$PATH"

function fn { find . -name "\"$1\"" -print; }
