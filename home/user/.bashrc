#
# ~/.bashrc
#

source $HOME/arch-hypr-dots/home/user/.bashrc.d/check
source $HOME/arch-hypr-dots/home/user/.bashrc.d/env-vars
source $HOME/arch-hypr-dots/home/user/.bashrc.d/shell-opts
source $HOME/arch-hypr-dots/home/user/.bashrc.d/pkgs.d/pkg-init
source $HOME/arch-hypr-dots/home/user/.bashrc.d/scripts
source $HOME/arch-hypr-dots/home/user/.bashrc.d/aliases
source $HOME/arch-hypr-dots/home/user/.bashrc.d/functions
source $HOME/arch-hypr-dots/home/user/.bashrc.d/prompt
source $HOME/arch-hypr-dots/home/user/.bashrc.d/final-inits
#source $HOME/arch-hypr-dots/home/user/.bashrc.d/aliases

# Created by `pipx` on 2025-04-06 19:29:37
export PATH="$PATH:/home/clinton/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
