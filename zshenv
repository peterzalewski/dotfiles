if [[ -x /usr/libexec/path_helper ]]; then
  export PATH=
  eval "$(/usr/libexec/path_helper -s)"
fi

# Roots
export RBENV_ROOT="${HOME}/.rbenv"
export GOROOT="/usr/local/go"

declare -a extra_paths
extra_paths=(
  "${HOME}/bin"
  "${RBENV_ROOT}/shims"
  "${GOROOT}/bin"
  "${HOME}/.cargo/bin"
  "/opt/local/bin"
)
declare -r extra_paths

for p in "${extra_paths[@]}"; do
  if [[ -d "${p}" ]]; then
    PATH="${p}:${PATH}"
  fi
done
export PATH

export KITTY_HOSTNAME="Peter-Zalewski"

if [[ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

if [[ -n "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export FZF_DEFAULT_COMMAND='rg --files --follow --glob=!{.git,node_modules}'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS='--color=dark --color=fg:15,bg:0,hl:1,fg+:#FFFFFF,bg+:0,hl+:1,prompt:3,pointer:3,marker:5,spinner:11,header:-1,info:6 --layout=reverse --info=hidden --prompt="❯ "'
export LANG='en_US.UTF-8'
declare -a less_options
less_options=(
  --LONG-PROMPT
  --RAW-CONTROL-CHARS
  --hilite-search
  --ignore-case
  --no-init
  --quit-if-one-screen
)
declare -r less_options
export LESS="${less_options[*]}"
export LESSHISTFILE='-'
export PAGER='less'
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export VISUAL="${EDITOR}"
