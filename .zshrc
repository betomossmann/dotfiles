# Fix Interop Error that randomly occurs in vscode terminal when using WSL2
fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Colormap
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# find out which distribution we are running
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# set an icon based on the distro
# make sure your font is compatible with https://github.com/lukas-w/font-logos
case $_distro in
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *macos*)                 ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DISTRO="$ICON "
export STARSHIP_DEVICE="$DEVICE "

# SHORTCUTS

# ALIAS COMMANDS
alias Ac='sudo apt autoclean'
alias Ag='sudo apt install'
alias Ai='apt show'
alias Ar='sudo apt remove'
alias Arm='sudo apt autoremove'
alias Arp='sudo apt remove --purge'
alias As='apt search'
alias rrf="rm -rf"
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -l"
alias work="cd /home/beto/Development"

# npm aliases
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nu='npm update'
alias nug='npm update -g'
alias np='npm prune'
alias nrm='npm rm'
alias ns='npm search'

# npm scripts aliases
alias start='npm start'
alias dev='npm run dev'
alias check='npm run check'
alias watch='npm run watch'
alias build='npm run build'
alias deploy='npm run deploy'
alias publish='npm run publish'
alias format='npm run format'
alias typecheck='npm run typecheck'
alias validate='npm run validate'
alias lint='npm run lint'
alias slint='npm run lint:styles'

# tests aliases
alias t='npm test'
alias tc='npm run test:coverage'
alias tw='npm run test:watch'

alias coverage='xdg-open coverage/lcov-report/index.html'
alias reinstall='rm -rf node_modules package-lock.json && npm i'
alias reload='source ~/.zshrc'

# plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Keep 10000 lines of history
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"