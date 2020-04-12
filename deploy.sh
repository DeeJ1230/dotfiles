#!/usr/bin/env bash

command -v ansible-playbook >/dev/null 2>&1 || { echo >&2 "[ansible-playbook] is required, but not installed.  Aborting."; exit 1; }

script_name=$(basename "$0")

function usage() {
  echo "Expected arguments: PROFILE_NAME"
  echo ""
  echo "Example:"
  echo "  $script_name dev"
}

if [ "$1" == "--help" ]; then
  usage
  exit 0
fi

if [ "$#" -ne "1" ]; then
  usage
  exit 1
fi

ROOT="$(dirname "$(readlink -f "$0")")"
profile_name=$1

if [ ! -d "$ROOT/profiles/$profile_name" ]; then
  echo "ERROR: cannot find [$profile_name] profile"
  exit 1
fi

if [ ! -f "$ROOT/profile-$profile_name.yaml" ]; then
  echo "ERROR: cannot find [$profile_name.yaml]"
  exit 1
fi

ansible-playbook -K -i profiles/$profile_name profile-$profile_name.yaml
