#!/usr/bin/env bash

alias tx="tmux"
alias txkill="tmux kill-session -t "
alias mux='tmuxinator'

function txopen {
  local -r target="${1:-}"
  local -r tmux=$(command -v tmux)
  local -r tmuxinator=$(command -v tmuxinator)

  if [[ -z "${tmux}" ]]; then
    printf "ERROR: tmux not installed\n" >&2
    return 1
  fi

  # No target given, so scrape available targets
  if [[ -z "${target}" ]]; then
    local -ra current_sessions=($("${tmux}" ls -F "#{session_name}" 2>/dev/null))
    if [[ "${#current_sessions[@]}" -gt 0 ]]; then
      printf "\e[0;95mOpen sessions:\e[0m\n"
      printf "%s\n" "${current_sessions[@]}"
    fi
    if [[ -n "${tmuxinator}" ]]; then
      local -ra tmuxinator_templates=($("${tmuxinator}" ls \
        | tr -s '[[:space:]]' '\n' \
        | awk 'NR>2'
      ))
      if [[ "${#tmuxinator_templates[@]}" -gt 0 ]]; then
        printf "\e[0;95mDefined sessions:\e[0m\n"
        printf "%s\n" "${tmuxinator_templates[@]}"
      fi
    fi
    return 0
  fi

  # Open the matching open session
  local -r current_session=$("${tmux}" ls -F "#{session_name}" 2>/dev/null | grep -m 1 "${target}")
  if [[ -n "${current_session}" ]]; then
    "${tmux}" attach -t "${current_session}"
    return 0
  fi

  # Open the matching tmuxinator template
  if [[ -n "${tmuxinator}" ]]; then
    local -r tmuxinator_template=$("${tmuxinator}" ls \
      | tr -s '[[:space:]]' '\n' \
      | awk 'NR>2' \
      | grep -m 1 "${target}" \
    )
    if [[ -n "${tmuxinator_template}" ]]; then
      "${tmuxinator}" start "${tmuxinator_template}"
      return 0
    fi
  fi

  # Otherwise open a new session using the target as name
  "${tmux}" new-session -s "${target}" -n "bash"
}
