#!/bin/sh

CONTENT=$(curl -is -H 'Accept-Encoding: gzip' -D - 'http://localhost:80/' -o /dev/null | grep -i 'gzip' )
RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo 'HTTP GZIP test: OK'
    exit 0
else
    echo 'HTTP GZIP test: FAILED with $RESULT'
    exit $RESULT
fi
