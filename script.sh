#!/bin/bash

REF=HEAD
SINCE=$(git reflog | grep -Eo '^[a-f0-9]{7,}' | sed -n '2p')
DIR_TO_CHECK=svc-1
# DIR_TO_CHECK=svc-2

MERGE_BASE=$(git merge-base ${SINCE} ${REF})
echo $MERGE_BASE
FILES_CHANGED=$(git diff --name-only ${MERGE_BASE}..${REF} -- ${DIR_TO_CHECK})
printf "Files changed:\n${FILES_CHANGED}\n"

if [[ -n $FILES_CHANGED ]]; then
  echo "Found changes !!! ... setting var to true"
#   echo 'export IS_CHANGED='"true" >> "$BASH_ENV"
else
  echo "No changes Found!!! ... setting var to false"
#   echo 'export IS_CHANGED='"false" >> "$BASH_ENV"
fi