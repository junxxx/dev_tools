alias ll="ls -la"
alias c="clear"

function git-branch-name {
    git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

function git-branch-prompt {
    local branch=`git-branch-name`
    if [ $branch ];then printf "=>%s" $branch; fi
}

# No Proxy
function noproxy {
#    /usr/local/sbin/noproxy  #turn off proxy server
    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
}

# Proxy
function setproxy {
#    sh /usr/local/sbin/proxyon  #turn on proxy server
    http_proxy=http://127.0.0.1:8118/
    HTTP_PROXY=$http_proxy
    https_proxy=$http_proxy
    HTTPS_PROXY=$https_proxy
    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
}
