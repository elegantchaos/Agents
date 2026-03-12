#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=${0:A:h}
source "${SCRIPT_DIR}/lib.sh"

usage() {
  cat <<'EOF'
Usage:
  audit-skill.sh --all
  audit-skill.sh <skill> [<skill> ...]
EOF
}

classify_skill() {
  local skill=$1
  local dir
  dir=$(skill_source_dir "${skill}")

  local secret_patterns='BEGIN [A-Z ]+PRIVATE KEY|gh[pousr]_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{20,}|AKIA[0-9A-Z]{12,}|ASIA[0-9A-Z]{12,}|client_secret'
  local path_patterns='/Users/sam/'
  local local_link_patterns='file://|/Users/sam|git@github.com:'

  local secrets portability local_links
  secrets=$(rg -n -S -g '!**/.git/**' "${secret_patterns}" "${dir}" || true)
  portability=$(rg -n -S -g '!**/.git/**' "${path_patterns}" "${dir}" || true)
  local_links=$(rg -n -S -g '!**/.git/**' "${local_link_patterns}" "${dir}" || true)

  local outcome notes
  notes=()

  if [[ -n "${secrets}" ]]; then
    outcome="not suitable for public extraction"
    notes+=("secret-like material detected")
  elif [[ -n "${portability}${local_links}" ]]; then
    outcome="safe after sanitization"
    [[ -n "${portability}" ]] && notes+=("machine-specific path assumptions detected")
    [[ -n "${local_links}" ]] && notes+=("local-only links or git transport references detected")
  else
    outcome="safe as-is"
    notes+=("no obvious secret or machine-local patterns detected")
  fi

  local publication_class
  publication_class=$(registry_field "${skill}" 3)
  print -- "| ${skill} | ${publication_class} | ${outcome} | ${notes[*]} |"
}

main() {
  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  local skills=()
  if [[ "$1" == "--all" ]]; then
    while IFS=$'\t' read -r skill _; do
      [[ "${skill}" == "skill" ]] && continue
      [[ "$(registry_field "${skill}" 5)" == "planned" ]] && continue
      [[ -d "$(skill_source_dir "${skill}")" ]] || continue
      skills+=("${skill}")
    done < "${REGISTRY_FILE}"
  else
    skills=("$@")
  fi

  print -- "# Public Skill Audit"
  print -- ""
  print -- "Source root: ${SKILLS_HOME} (falls back to packaged snapshots in this repository if a checkout is missing)"
  print -- ""
  print -- "| Skill | Class | Outcome | Notes |"
  print -- "| --- | --- | --- | --- |"

  local skill
  for skill in "${skills[@]}"; do
    classify_skill "${skill}"
  done
}

main "$@"
