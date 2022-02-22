RED=52
WHITE=255
DARKGRAY=236
GRAY=240
LIGHTGRAY=252
LIGHTBLUE=31
B=''
BR=''

ERRORC="$(tput setaf $WHITE; tput setab $RED)"
NC='\e[0m'
if [ $EUID == 0 ]; then
    USERC="$(tput setaf $WHITE; tput setab $RED)"
else
    USERC="$(tput setaf $WHITE; tput setab $LIGHTBLUE)"
fi
BRANCHC="$(tput setaf $LIGHTGRAY; tput setab $DARKGRAY)"
DIRC="$(tput setaf $LIGHTGRAY; tput setab $GRAY)"

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$ERRORC $RETVAL "
}

# get current branch in git repo
function parse_git_branch() {
	exit_code=$?
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
    then
		echo "${BRANCHC} ${BR} ${BRANCH} "
	else
		echo ""
	fi
	return $exit_code
}

export PS1="${USERC} \u \`parse_git_branch\`${DIRC} \w\ \`nonzero_return\`${NC} "