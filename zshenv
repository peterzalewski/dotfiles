if [[ -x /usr/libexec/path_helper ]]; then
  export PATH=
  eval "$(/usr/libexec/path_helper -s)"
fi

declare -a extra_paths
extra_paths=(
  "${HOME}/bin"
  "${GOROOT}/bin"
  "${HOME}/.cargo/bin"
  "/opt/local/bin"
  "${HOME}/.rd/bin"
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
declare -a fzf_options
fzf_options=(
  --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284
  --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf
  --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284
  --color=gutter:#303446,scrollbar:#f2d5cf,pointer:#ef9f76
  --color=preview-border:#8caaee,preview-scrollbar:#f2d5cf
  --separator=""
  --layout=reverse
  --scrollbar="█"
  --info=hidden
  --prompt="❯ "
)
export FZF_DEFAULT_OPTS="${fzf_options[*]}"
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
