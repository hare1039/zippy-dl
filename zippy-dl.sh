#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    SCRIPT=$(greadlink -f "$0");
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    SCRIPT=$(readlink -f "$0");
fi

export SCRIPTPATH=$(dirname "$SCRIPT");
source "$SCRIPTPATH/zippylib.sh";

trap '
  trap - INT # restore default INT handler
  kill -s INT "$$"
' INT
usage() {
    cat - <<EOF
usage: zippy-dl.sh [url [url ...]]

positional arguments:
  url

optional arguments:
  -h       show this help message and exit

EOF
}

while getopts "tu:p:csrhi:fdn" argv; do
    case $argv in
        h | *)
            usage
            exit
            ;;
    esac
done
shift $((OPTIND-1))

args=("$@")

if ! (( $(calc-argc "${args[@]}") )); then
    echo "Missing [urls/ids]";
    exit 0;
fi

for url in "${args[@]}"; do
    zippy-dl-by-url "$url"
done
