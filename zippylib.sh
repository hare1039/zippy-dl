#!/usr/bin/env bash
PYCHECK="import sys; html=sys.stdin.read(); import os; os.chdir('${SCRIPTPATH}'); import zippylib as page;"

calc-argc()
{
    local argv_count=0
    for url in "$@"; do argv_count=$((V + 1)) ; done
    echo "$argv_count"
}

get-html-from-url()
{
    local URL=$1
    HTML=$(curl "$URL" -L --silent)
}

zippy-dl-by-url()
{
    local URL=$1
    get-html-from-url "${URL}"
    local dl_url=$(echo "$HTML" | python3 -c "$PYCHECK page.find_dlbutton(html);")
    local host=$(echo "$URL" | python3 -c "$PYCHECK page.get_host(html);")
    curl -O "$host$dl_url"
}
