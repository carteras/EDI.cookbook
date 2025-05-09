#!/bin/bash
set -x
if [ $# -lt 2 ]; then
    echo "Usage: $0 <filename-pattern> <search-string>"
    exit 1
fi
PATTERN=$1
STRING=$2
find / -type f -name "$PATTERN" -print0 2>/dev/null | xargs -0 grep -l "$STRING" 2>/dev/null