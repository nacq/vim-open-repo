#!/usr/bin/env bash

# Script to execute from vim to get a browser window open on the
# current file and line number
#
# $1 filename
# $2 default_branch
# $3 line number start
# $4 line number end

[[ ! -d .git ]] && echo "Not in a git repo" && exit 1

CURRENT_BRANCH=$2
[[ $CURRENT_BRANCH == '0' ]] && CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

REMOTE=`git remote -v`
LINE_PARAM=$3
REPO_URL=`echo $REMOTE | head -n 1 | awk '{ print $2 }' | sed 's/\.git//g'`

[[ `echo $REMOTE | grep git@` ]] && REPO_URL='https://'`echo $REPO_URL | awk -F '@' '{ print $2 }' | \
    sed 's/\:/\//g'`

[[ `echo $REPO_URL | grep bitbucket` ]] && REPO_URL='https://'`echo $REPO_URL | awk -F '@' '{ print $2 }'` && \
  LATEST_COMMIT=`git show | head -n 1 | awk '{ print $2 }'`

if [[ $4 ]]; then
  [[ `echo $REPO_URL | grep github` ]] && LINE_PARAM=$LINE_PARAM':L'$4
  [[ `echo $REPO_URL | grep gitlab` ]] && LINE_PARAM=$LINE_PARAM'-'$4

  if [[ `echo $REPO_URL | grep bitbucket` ]]; then
    LINE_PARAM='#lines-'$LINE_PARAM':'$4
    open "$REPO_URL/src/$LATEST_COMMIT/$1$LINE_PARAM"

    exit 0
  fi
fi

if [[ `echo $REPO_URL | grep bitbucket` ]]; then
  open "$REPO_URL/src/$LATEST_COMMIT/$1#lines-$LINE_PARAM"

  exit 0
fi

# open url in default browser
URL=$REPO_URL/blob/$CURRENT_BRANCH/$1#L$LINE_PARAM

case $OSTYPE in
  darwin) open $URL ;;
  darwin18) open $URL ;;
  darwin19) open $URL ;;
  linux-gnu) xdg-open $URL ;;
esac
