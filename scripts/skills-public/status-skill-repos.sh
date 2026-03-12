#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=${0:A:h}
source "${SCRIPT_DIR}/lib.sh"

readonly AGENTS_SKILLS_DIR="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"
readonly CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"

print_status() {
  local skill=$1
  local repo_dir target_dir expected_ref agents_link codex_link head_ref dirty ahead behind
  repo_dir=$(checkout_dir "${skill}")
  target_dir=$(runtime_dir "${skill}")
  expected_ref=$(registry_field "${skill}" 7)
  agents_link="${AGENTS_SKILLS_DIR}/${skill}"
  codex_link="${CODEX_SKILLS_DIR}/${skill}"

  if [[ ! -d "${repo_dir}/.git" ]]; then
    print -- "| ${skill} | missing checkout | - | - | - | - |"
    return
  fi

  head_ref=$(git -C "${repo_dir}" rev-parse HEAD)
  dirty="clean"
  if [[ -n "$(git -C "${repo_dir}" status --short)" ]]; then
    dirty="dirty"
  fi

  ahead="n/a"
  behind="n/a"
  if git -C "${repo_dir}" rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1; then
    read ahead behind < <(git -C "${repo_dir}" rev-list --left-right --count HEAD...@{upstream})
  fi

  local ref_status="ok"
  [[ -n "${expected_ref}" && "${expected_ref}" != "${head_ref}" ]] && ref_status="registry-mismatch"

  local agents_status="ok"
  if [[ ! -L "${agents_link}" || "$(readlink "${agents_link}")" != "${target_dir}" ]]; then
    agents_status="mismatch"
  fi

  local codex_status="ok"
  if [[ ! -L "${codex_link}" || "$(readlink "${codex_link}")" != "${target_dir}" ]]; then
    codex_status="mismatch"
  fi

  print -- "| ${skill} | ${dirty} | ${ahead}/${behind} | ${ref_status} | ${agents_status} | ${codex_status} |"
}

main() {
  print -- "# Skill Repo Status"
  print -- ""
  print -- "Checkout root: ${SKILLS_HOME}"
  print -- ""
  print -- "| Skill | Working Tree | Ahead/Behind | Registry Ref | ~/.agents | ~/.codex |"
  print -- "| --- | --- | --- | --- | --- | --- |"

  local skill
  while IFS=$'\t' read -r skill _; do
    [[ "${skill}" == "skill" ]] && continue
    print_status "${skill}"
  done < "${REGISTRY_FILE}"
}

main "$@"
