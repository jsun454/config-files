alias vi=vim
alias r=clear
alias c=clear
alias src="source ~/.bash_profile"
alias edit="vi ~/.bash_profile"
export GITHUB_USERNAME=jsun454
export BASH_SILENCE_DEPRECATION_WARNING=1
export PS1="\[\e[3;36m\][\u@\h \W]\$:\[\e[0m\]"
export CLICOLOR=1
export LSCOLORS=exgxbxdxcxegedxbxgxcxd

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

undo () {
  green="\033[32m"
  yellow="\033[33m"
  reset="\033[0m"
  if [ -z "$1" ]; then
    echo -e "${yellow}Please specify the name of the GitHub repository to undo the latest commit to (e.g. undo my-repo-name).$reset"
  elif [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${yellow}GitHub username not found."
    echo -e "Please add your GitHub username to ~/.bash_profile (e.g. export GITHUB_USERNAME=my-username).$reset"
  else
    branch=master
    if [ ! -z "$2" ]; then
      branch="$2"
    fi
    read -p $'\e[33m'"Are you sure you want to undo the latest commit on the $branch branch of $GITHUB_USERNAME/$1? [y/N]: "$'\e[0m' yn
    case "$yn" in
      [Yy]*)
        echo -e "${green}Preparing to undo changes...$reset"
        dir="temp-$1"
        mkdir "$dir"
        cd "$dir"
        git init
        git remote add origin "git@github.com:$GITHUB_USERNAME/$1.git"
        git checkout -b "$branch"
        git pull origin "$branch"
        git reset --hard "origin/$branch~1"
        git push -f origin "$branch"
        cd ..
        rm -rf "$dir"
        # For now just print a generic message w/o checking for success/failure
        echo "Done."
        ;;
      *)
        echo "No changes were made."
        ;;
    esac

  fi
}
