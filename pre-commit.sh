#!/usr/bin/env bash

EXIT_CODE=0
IGNORE_JS_FILES=":!.eslint*"
JS_CHANGED_FILES=$(git diff --name-only --diff-filter=ACM :*.js ${IGNORE_JS_FILES})
ALL_CHANGED_FILES=$(git diff --name-only --diff-filter=ACM)
CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

# Colors
WHITE='\033[97m'
GREY='\033[38;5;245m'
RED='\033[38;5;196m'
GREEN='\033[38;5;42m'
BLUE='\033[38;5;75m'
YELLOW='\033[38;5;228m'

# Other
BOLD=$(tput bold)
UNDERLINE=$(tput smul)
RESET=$(tput sgr0)

# Styles
STYLE_TITLE="${BOLD}${UNDERLINE}${WHITE}"
STYLE_BRIGHT="${BOLD}${WHITE}"
STYLE_DIM="${GREY}"
STYLE_INFO="${BOLD}${YELLOW}"
STYLE_GOOD="${BOLD}${GREEN}"
STYLE_BAD="${BOLD}${RED}"
STYLE_INPUT="${BLUE}"


echol(){
	echo && echo -e "${@}${RESET}"
}

listFiles(){
	echol "${STYLE_TITLE}${1}${RESET}"
	while IFS=' ' read -ra FILES; do
		for i in "${FILES[@]}"; do
			echo -e "${STYLE_DIM}${i}"
		done
	done <<< ${2}
}

addCommit(){
  COMMIT_MESSAGE=''
  echo
  while [ -z "$COMMIT_MESSAGE" ]; do
  	echo -e "${STYLE_BRIGHT}Enter commit message ${RESET}${STYLE_DIM}(q to cancel)${STYLE_INPUT}"
    read COMMIT_MESSAGE
	done

  echo "$RESET"

	if [ "$COMMIT_MESSAGE" = "q" ]
	then exit 0
	fi

	git add -A && git commit -m "$COMMIT_MESSAGE"
}

pushBranch(){
  SHOULD_PUSH=''
  echo
  while [ -z "$SHOULD_PUSH" ]; do
  	echo -e "${STYLE_BRIGHT}Would you like to push this branch? ${STYLE_DIM}(${STYLE_INFO}${CURRENT_BRANCH}${STYLE_DIM})${RESET}"
    echo -e "${STYLE_DIM}Enter y if YES, anything else means no${STYLE_INPUT}"
    read SHOULD_PUSH
	done

  if [ "$SHOULD_PUSH" = "y" ] || [ "$SHOULD_PUSH" = "Y" ]
	then
	  echo "$RESET"
	  git push origin ${CURRENT_BRANCH}
	fi
}

# Check for eslint
which eslint &> /dev/null
if [[ "$?" == 1 ]]; then
  echo "${STYLE_BAD}Please install eslint${RESET}"
  echo "$RESET"
  exit 1
fi

# Check if any files have changed
if [ -z "$ALL_CHANGED_FILES" ]
then
  echol "${STYLE_INFO}No Files Changed"
  echo "$RESET"
  exit 0
else
  listFiles 'All Changed Files' "$ALL_CHANGED_FILES"
fi

# Check if any javascript files have changed
if [ -z "$JS_CHANGED_FILES" ]
then
  echol "${STYLE_INFO}No Files To Lint"
  echo "$RESET"
  addCommit
  pushBranch
  exit 0
else

  listFiles 'Files To Lint' "$JS_CHANGED_FILES"

  eslint \
    --fix \
    --fix-type layout \
    --max-warnings 0 \
    ${JS_CHANGED_FILES}
  #
  # DO NOT RUN ANY COMMANDS between eslint and EXIT_CODE
  # EXIT_CODE must be set first to get the eslint exit code
  EXIT_CODE=$?

  if [ ${EXIT_CODE} -eq 0 ]
  then
    echol "${STYLE_GOOD}ESlint Succeeded: No warnings/errors"
    addCommit
    pushBranch
  else
    echol "${STYLE_BAD}ESlint Failed: Please fix the warnings/errors listen above"
  fi

  echo "$RESET"
  exit 0
fi



