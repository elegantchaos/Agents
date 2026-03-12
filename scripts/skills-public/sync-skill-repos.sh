#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=${0:A:h}
source "${SCRIPT_DIR}/lib.sh"

usage() {
  cat <<'EOF'
Usage:
  sync-skill-repos.sh --all
  sync-skill-repos.sh <skill> [<skill> ...]
EOF
}

sync_one() {
  local skill=$1
  local repo_url repo_name destination
  repo_url=$(repo_url_for_skill "${skill}")
  repo_name=$(repo_name_for_skill "${skill}")
  destination=$(checkout_dir "${skill}")

  mkdir -p "${SKILLS_HOME}"

  if [[ -d "${destination}/.git" ]]; then
    git -C "${destination}" pull --ff-only >/dev/null
  else
    rm -rf "${destination}"
    gh repo clone "${repo_url#https://github.com/}" "${destination}" >/dev/null
  fi

  if git -C "${destination}" rev-parse --verify HEAD >/dev/null 2>&1; then
    update_synced_ref "${skill}" "$(git -C "${destination}" rev-parse HEAD)"
  fi

  print -- "${skill}: ${destination}"
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
      skills+=("${skill}")
    done < "${REGISTRY_FILE}"
  else
    skills=("$@")
  fi

  local skill
  for skill in "${skills[@]}"; do
    sync_one "${skill}"
  done
}

main "$@"
