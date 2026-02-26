export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"${HOME}/.cache"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"

if [[ -x /usr/libexec/path_helper ]]; then
  export PATH=
  eval "$(/usr/libexec/path_helper -s)"
fi

declare -a extra_paths
extra_paths=(
  "${HOME}/.local/bin"
  "${GOROOT}/bin"
  "${HOME}/go/bin"
  "${CARGO_HOME}/bin"
  "/opt/local/bin"
  "${HOME}/.local/share/npm/bin"
)
declare -r extra_paths

for p in "${extra_paths[@]}"; do
  if [[ -d "${p}" ]]; then
    PATH="${p}:${PATH}"
  fi
done
export PATH

if command -v nvim &>/dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
export VISUAL="${EDITOR}"

export FZF_DEFAULT_COMMAND='rg --files --glob=!{.git,node_modules}'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_Y_COMMAND="fd -td --color=never"
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
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
fi

# Python ecosystem
export PYTHON_HISTORY="${XDG_CACHE_HOME}/python_history"
# pip config?

# Postgres
export PSQLRC="${XDG_CONFIG_HOME}/psql/config"
export PSQL_HISTORY="${XDG_CACHE_HOME}/psql_history"

# Node ecosystem
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Rust ecosystem
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

if [[ -e "${CARGO_HOME}/env" ]]; then
  . "${CARGO_HOME}/env"
fi

if command -v vivid &>/dev/null; then
  export LS_COLORS="$(vivid generate catppuccin-frappe)"
else
  export LS_COLORS='ExFxcxdxBxegedabagacad'
fi

if [[ -e "${XDG_CONFIG_HOME}/zsh/.zshenv.local" ]]; then
  . "${XDG_CONFIG_HOME}/zsh/.zshenv.local"
fi
