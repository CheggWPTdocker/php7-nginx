#!/bin/sh

CONTENT=$(curl -is -H 'Accept-Encoding: gzip' -D - 'http://localhost:80/' -o /dev/null | grep -i '200 OK' )
RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo 'HTTP test: OK'
    exit 0
else
    echo 'HTTP test: FAILED with $RESULT'
    exit $RESULT
fi
