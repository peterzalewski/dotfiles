#!/usr/bin/env bash

alias tx="tmux"
alias txkill="tmux kill-session -t "
alias mux='tmuxinator'

txopen() {
  local -r tmux=$(command -v tmux)
  local -r tmuxinator=$(command -v tmuxinator)
  if [[ -z "${tmux}" ]]; then
    printf "ERROR: tmux not installed\n"
    return 1
  fi
  local -r target="${1:-}"
  if [[ -z "${target}" ]]; then
    local -ra current_sessions=($("${tmux}" ls -F "#{session_name}"))
    if [[ "${#current_sessions[@]}" -gt 0 ]]; then
      printf "Open sessions:\n"
      printf "%s\n" "${current_sessions[@]}"
    fi
    local -ra tmuxinator_templates=($("${tmuxinator}" ls \
      | tr -s '[[:space:]]' '\n' \
      | awk 'NR>2'
    ))
    if [[ "${#tmuxinator_templates[@]}" -gt 0 ]]; then
      printf "Defined sessions:\n"
      printf "%s\n" "${tmuxinator_templates[@]}"
    fi
    return
  fi
  local -r current_session=$("${tmux}" ls -F "#{session_name}" | grep -m 1 "${target}")
  if [[ -n "${current_session}" ]]; then
    "${tmux}" attach -t "${current_session}"
    return 0
  fi
  if [[ -n "${tmuxinator}" ]]; then
    local -r tmuxinator_template=$("${tmuxinator}" ls \
      | tr -s '[[:space:]]' '\n' \
      | awk 'NR>2' \
      | grep -m 1 "${target}" \
    )
    if [[ -n "${tmuxinator_template}" ]]; then
      "${tmuxinator}" start "${tmuxinator_template}"
      return
    fi
  fi
  "${tmux}" new-session -s "${target}" -n "bash"
}
