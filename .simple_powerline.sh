RED=52
WHITE=255
DARKGRAY=236
GRAY=240
LIGHTGRAY=252
LIGHTBLUE=31
B=''
BR=''

NC='\[\e[0m\]'

function error_color() {
    tput setaf $WHITE
    tput setab $RED
}

function dir_color() {
    tput setaf $LIGHTGRAY
    tput setab $GRAY
}

function user_color() {
    if [ $EUID == 0 ]
    then
        tput setab $RED
    else
        tput setab $LIGHTBLUE
    fi
    tput setaf $WHITE
}

function branch_color() {
    tput setaf $LIGHTGRAY
    tput setab $DARKGRAY
}

function nonzero_return() {
    RETVAL=$?
    if [ $RETVAL -ne 0 ]
    then
        error_color
        echo " $RETVAL "
    fi
}

# get current branch in git repo
function parse_git_branch() {
    exit_code=$?
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        branch_color
        echo " ${BR} ${BRANCH} "
    fi
    return $exit_code
}

function get_cwd() {
    exit_code=$?
    dir_color
    return $exit_code
}

function get_user() {
    exit_code=$?
    user_color
    echo " ${USER} "
    return $exit_code
}

export PS1="\`get_user\`\`parse_git_branch\`\`get_cwd\` \w \`nonzero_return\`${NC} "
