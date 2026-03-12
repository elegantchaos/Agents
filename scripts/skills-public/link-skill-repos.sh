#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=${0:A:h}
source "${SCRIPT_DIR}/lib.sh"

readonly AGENTS_SKILLS_DIR="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"
readonly CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"
readonly LOCAL_MAINTENANCE_SKILL="${REPO_ROOT}/codex/skills/refresh-public-skills"

usage() {
  cat <<'EOF'
Usage:
  link-skill-repos.sh [--agents-only] [--codex-only]
EOF
}

link_target_dir() {
  local link_root=$1
  local skill=$2
  local target
  target=$(runtime_dir "${skill}")
  [[ -d "${target}" ]] || fail "Missing checkout for ${skill}: ${target}"
  ln -sfn "${target}" "${link_root}/${skill}"
}

main() {
  local link_agents=1
  local link_codex=1

  case "${1:-}" in
    --agents-only)
      link_codex=0
      ;;
    --codex-only)
      link_agents=0
      ;;
    "" )
      ;;
    * )
      usage
      exit 1
      ;;
  esac

  (( link_agents )) && mkdir -p "${AGENTS_SKILLS_DIR}"
  (( link_codex )) && mkdir -p "${CODEX_SKILLS_DIR}"

  local skill
  while IFS=$'\t' read -r skill _; do
    [[ "${skill}" == "skill" ]] && continue
    if (( link_agents )); then
      link_target_dir "${AGENTS_SKILLS_DIR}" "${skill}"
    fi
    if (( link_codex )); then
      link_target_dir "${CODEX_SKILLS_DIR}" "${skill}"
    fi
  done < "${REGISTRY_FILE}"

  if (( link_agents )) && [[ -d "${LOCAL_MAINTENANCE_SKILL}" ]]; then
    ln -sfn "${LOCAL_MAINTENANCE_SKILL}" "${AGENTS_SKILLS_DIR}/refresh-public-skills"
  fi
}

main "$@"
