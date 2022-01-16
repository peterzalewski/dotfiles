#compdef topen t
##############################################################################
# Author: Peter Zalewski <peter@zalewski.com>
# Source: https://github.com/peterzalewski/dotfiles/blob/master/bash.d/tmux.sh
##############################################################################

alias mux='tmuxinator'
alias t='txopen'
alias tx='tmux'
alias txkill='tmux kill-session -t'

##############################################################################
# Stream a list of open tmux sessions
##############################################################################
function _tmux_sessions {
  local -r tmux="$(command -v tmux)"
  [[ -n "${tmux}" ]] && "${tmux}" ls -F "#{session_name}" 2>/dev/null
}

##############################################################################
# Stream a list of Tmuxinator projects
##############################################################################
function _tmuxinator_projects {
  local -r tmuxinator="$(command -v tmuxinator)"
  [[ -n "${tmuxinator}" ]] && "${tmuxinator}" list -n | sed -n '2,$p'
}

##############################################################################
# Given the name of a tmux session, attempt the following:
#   1. Open an existing tmux session with that name
#   2. Start a defined Tmuxinator project with that name
#   3. Start a new tmux session with that name
# If no name is given, list existing sessions and projects.
# Arguments:
#   $1 target: [optional] name of a tmux session
##############################################################################
function txopen {
  local -r target="${1:-}"
  local -r tmux="$(command -v tmux)"
  local -r tmuxinator="$(command -v tmuxinator)"

  if [[ -z "${tmux}" ]]; then
                                              # /-> Bold + red
    printf '%bERROR:%b tmux not installed\n' "$(tput bold ; tput setaf 1)" "$(tput sgr0)" >&2
    return 1
  fi

  # No target given, so scrape available targets
  if [[ -z "${target}" ]]; then
    local -r current_sessions=("${(@f)$(_tmux_sessions)}")
    if [[ "${#current_sessions[@]}" -gt 0 ]]; then
                                     # /-> Bold + cyan
      printf '%bOpen sessions:%b\n' "$(tput bold ; tput setaf 6)" "$(tput sgr0)"
      printf '%s\n' "${current_sessions[@]}"
    fi
    if [[ -n "${tmuxinator}" ]]; then
      local -r tmuxinator_projects=("${(@f)$(_tmuxinator_projects)}")
      if [[ "${#tmuxinator_projects[@]}" -gt 0 ]]; then
                                          # /-> Bold + blue
        printf '%bDefined sessions:%b\n' "$(tput bold ; tput setaf 4)" "$(tput sgr0)"
        printf '%s\n' "${tmuxinator_projects[@]}"
      fi
    fi
    return 0
  fi

  # Open the matching open session
  local -r current_session="$(_tmux_sessions | grep --max-count=1 "${target}")"
  if [[ -n "${current_session}" ]]; then
    "${tmux}" attach -t "${current_session}"
    return 0
  fi

  # Open the matching Tmuxinator project
  if [[ -n "${tmuxinator}" ]]; then
    local -r tmuxinator_project="$(_tmuxinator_projects \
      | grep --max-count=1 "${target}" \
    )"
    if [[ -n "${tmuxinator_project}" ]]; then
      "${tmuxinator}" start "${tmuxinator_project}"
      return 0
    fi
  fi

  # Otherwise open a new session using the target as name
  "${tmux}" new-session -s "${target}" -n "bash"
}

##############################################################################
# Return matching names of tmux sessions and Tmuxinator projects for tab-
# completion.
##############################################################################
function _txopen_complete {
  if [[ "${#COMP_WORDS[@]}" != 2 ]]; then
    return
  fi

  mapfile -t COMPREPLY < <(compgen -W "$(_tmux_sessions)" -- "${COMP_WORDS[1]}")
  mapfile -t COMPREPLY -O "${#COMPREPLY[@]}" < <(compgen -W "$(_tmuxinator_projects)" -- "${COMP_WORDS[1]}")
}

compdef _txopen_complete txopen t
