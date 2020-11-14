#!/usr/bin/env bash

# Script to execute from vim to get a browser window open on the
# current file and line number
#
# $1 filename
# $2 line number

[[ ! -d .git ]] && echo "Not in a git repo" && exit 1

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
REPO_URL=`git remote -v | \
  head -n 1 | \
  awk '{ print $2 }' | \
  sed 's/\.git//g'`

if [[ `git remote -v | grep git@` ]]; then
    REPO_URL='https://'`echo $REPO_URL | \
      awk -F '@' '{ print $2 }' | \
      sed 's/\:/\//g'`
fi

echo $REPO_URL

# open url in default browser
open "$REPO_URL/blob/$CURRENT_BRANCH/$1#L$2"
