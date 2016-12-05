#!/bin/bash

VERSION=0.0.1
declare -i IGNORE_FILES_COUNT=0
declare -a IGNORE_FILES=()

usage () {
  echo "git-tree [-hV]"
  echo
  echo "Options:"
  echo "  -f|--file      File containing list of files to ignore"
  echo "  -h|--help      Print this help dialogue and exit"
  echo "  -V|--version   Print the current version and exit"
}

git-tree () {
  local next
  local opts=($@)
  local opt
  local i

  if test -f .gitignore; then
    IGNORE_FILES+=(.gitignore)
    ((IGNORE_FILES_COUNT++))
  fi

  for (( i = 0; i < ${#}; i++ )); do
    opt="${opts[$i]}"
    next="${opts[((i + 1))]}"
    case "$opt" in
      -f|--file)
        if test -f $next; then
          IGNORE_FILES+=($next)
          ((IGNORE_FILES_COUNT++))
        fi
        ;;

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
  if [[ $IGNORE_FILES_COUNT -gt 0 ]]; then
    tree . -I `cat "${IGNORE_FILES[@]}" | sed '/^#/d' | tr '[[:space:]]' ' ' | tr '\/$' ' ' | xargs echo | tr '[[:space:]]' '|' | uniq`
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
