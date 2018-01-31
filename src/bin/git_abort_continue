#!/bin/bash

command="${1}"

case "${command}" in
  # Only allow these commands
  'continue'|'abort');;
  # All other commands are ignored
  *) exit;;
esac

git_dir="$(git rev-parse --git-dir 2> /dev/null)"

if [ $? != 0 ]; then
  echo 'fatal: Not a git repository'
  exit 1
fi

# Cherry picking
if [ -e "${git_dir}/CHERRY_PICK_HEAD" ]; then
  git cherry-pick "--${command}"
  exit $?
fi

# Rebasing
if [ -e "${git_dir}/ORIG_HEAD" ]; then
  git rebase "--${command}"
  exit $?
fi

# Merging
if [ -e "${git_dir}/MERGE_HEAD" ]; then
  git merge "--${command}"
  exit $?
fi
