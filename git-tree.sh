#!/bin/bash

VERSION=0.0.1

usage () {
  echo "git-tree [-hV]"
  echo
  echo "Options:"
  echo "  -h|--help      Print this help dialogue and exit"
  echo "  -V|--version   Print the current version and exit"
}

git-tree () {
  for opt in "${@}"; do
    case "$opt" in
      -h|--help)
        usage
        return 0
        ;;
      -V|--version)
        echo "$VERSION"
        return 0
        ;;
    esac
  done

  ## your code here
  if test -f .gitignore; then
    tree . -I `cat .gitignore | sed '/^#/d' | tr '[[:space:]]' ' ' | xargs echo | tr '[[:space:]]' '|'`
  else
    tree .
  fi
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f git-tree
else
  git-tree "${@}"
  exit 0
fi
