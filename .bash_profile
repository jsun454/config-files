alias vi='vim'
alias r='clear'
alias c='clear'
alias src='source ~/.bash_profile'
alias edit='vi ~/.bash_profile'
export BASH_SILENCE_DEPRECATION_WARNING=1

cpconfig () {
  green="\033[32m"
  yellow="\033[33m"
  reset="\033[0m"
  dest="$HOME/config"
  if [ -z "$1" ]; then
    echo -e "${yellow}Target directory not specified. Defaulting to $dest.$reset"
    if [ ! -d "$dest" ] ; then
      echo -e "${yellow}The $dest directory does not exist and will be created now.$reset"
      mkdir -p "$dest"
    fi
  else
    dest="$1"
    echo -e "${yellow}Config files will be copied into $dest.$reset"
    if [ ! -d "$dest" ] ; then
      echo -e "${yellow}The directory does not exist and will be created now.$reset"
      mkdir -p "$dest"
    fi
  fi
  echo -e "${green}Copying files...$reset"
  declare -a ConfigFiles=("$HOME/.bash_profile" "$HOME/.zshrc" "$HOME/.vimrc")
  for f in ${ConfigFiles[@]}; do
    echo "Copying $f into $dest"
    cp "$f" "$dest"
  done
  echo -e "${green}Done.$reset"
}
