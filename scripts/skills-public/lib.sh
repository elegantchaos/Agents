#!/bin/zsh

set -euo pipefail

readonly SCRIPT_DIR=${0:A:h}
readonly REPO_ROOT=${SCRIPT_DIR:h:h}
readonly REGISTRY_FILE="${REPO_ROOT}/codex/skills/public-skill-registry.tsv"
readonly TEMPLATE_DIR="${REPO_ROOT}/templates/skill-repo"
readonly SKILLS_HOME="${SKILLS_HOME:-$HOME/.local/share/skills}"

fail() {
  print -u2 -- "$1"
  exit 1
}

ensure_registry() {
  [[ -f "${REGISTRY_FILE}" ]] || fail "Missing registry: ${REGISTRY_FILE}"
}

skill_dir() {
  print -- "${REPO_ROOT}/codex/skills/$1"
}

repo_url_for_skill() {
  registry_field "$1" 2
}

link_subpath_for_skill() {
  registry_field "$1" 11
}

repo_name_for_skill() {
  local repo_url
  repo_url=$(repo_url_for_skill "$1")
  repo_url=${repo_url%.git}
  print -- "${repo_url##*/}"
}

checkout_dir() {
  print -- "${SKILLS_HOME}/$(repo_name_for_skill "$1")"
}

runtime_dir() {
  local skill=$1
  local base subpath
  base=$(checkout_dir "${skill}")
  subpath=$(link_subpath_for_skill "${skill}")
  if [[ -n "${subpath}" ]]; then
    print -- "${base}/${subpath}"
  else
    print -- "${base}"
  fi
}

skill_source_dir() {
  local skill=$1
  local checkout
  checkout=$(checkout_dir "${skill}")
  if [[ -d "${checkout}" ]]; then
    print -- "${checkout}"
  else
    print -- "$(skill_dir "${skill}")"
  fi
}

load_skill_record() {
  local skill=$1
  ensure_registry
  awk -F '\t' -v target="${skill}" '
    NR == 1 { next }
    $1 == target { print; found = 1 }
    END { if (!found) exit 1 }
  ' "${REGISTRY_FILE}" || fail "Unknown skill: ${skill}"
}

registry_field() {
  local skill=$1
  local index=$2
  local record
  record=$(load_skill_record "${skill}")
  print -- "${record}" | awk -F '\t' -v idx="${index}" '{ print $idx }'
}

update_synced_ref() {
  local skill=$1
  local ref=$2
  local tmp
  tmp=$(mktemp)
  awk -F '\t' -v OFS='\t' -v target="${skill}" -v ref="${ref}" '
    NR == 1 { print; next }
    $1 == target { $7 = ref }
    { print }
  ' "${REGISTRY_FILE}" > "${tmp}"
  mv "${tmp}" "${REGISTRY_FILE}"
}

copy_skill_payload() {
  local source_dir=$1
  local dest_dir=$2
  mkdir -p "${dest_dir}"

  local entry
  for entry in SKILL.md agents assets references scripts; do
    if [[ -e "${source_dir}/${entry}" ]]; then
      rm -rf "${dest_dir}/${entry}"
      cp -R "${source_dir}/${entry}" "${dest_dir}/${entry}"
    fi
  done
}

require_skill_dir() {
  local skill=$1
  local dir
  dir=$(skill_dir "${skill}")
  [[ -d "${dir}" ]] || fail "Missing packaged skill directory: ${dir}"
}

require_checkout_dir() {
  local skill=$1
  local dir
  dir=$(checkout_dir "${skill}")
  [[ -d "${dir}" ]] || fail "Missing skill checkout directory: ${dir}"
}
