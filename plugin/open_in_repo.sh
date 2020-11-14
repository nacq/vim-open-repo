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
[[ ! $CURRENT_BRANCH ]] && CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

REMOTE=`git remote -v`
LINE_PARAM=$3
REPO_URL=`echo $REMOTE | head -n 1 | awk '{ print $2 }' | sed 's/\.git//g'`

[[ `echo $REMOTE | grep git@` ]] && REPO_URL='https://'`echo $REPO_URL | awk -F '@' '{ print $2 }' | \
    sed 's/\:/\//g'`

[[ `echo $REPO_URL | grep github` && $4 ]] && LINE_PARAM=$LINE_PARAM':L'$4

# open url in default browser
open "$REPO_URL/blob/$CURRENT_BRANCH/$1#L$LINE_PARAM"
