#!/usr/bin/env bash

usage () {
  echo "Usage: $0 -s <storynum (or any pattern)> -r <commitrange>"
  echo
  echo "Example: $0 -s 12345 -r 548e56dad16..master"
  exit 1
}

while getopts 'hs:r:' opt; do
  case "$opt" in
    h)
      usage
      ;;
    s)
      story_num=$OPTARG
      ;;
    r)
      commit_range=$OPTARG
      ;;
  esac
done

if [ -z "${story_num}" ] || [ -z "${commit_range}" ]; then
    echo "Missing arguments"
    echo
    usage
fi

hashes=$(git log "${commit_range}" --grep="${story_num}" --pretty=format:"%h" --no-merges --topo-order --reverse | sed 's/\n/ /g')

# TODO: quit safely on error

git cherry-pick ${hashes} --allow-empty --keep-redundant-commits --strategy=ort -X their

