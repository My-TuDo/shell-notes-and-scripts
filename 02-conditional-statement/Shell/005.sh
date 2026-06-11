#!/bin/bash

ANSWER=maybe

if [ -z "$ANSWER" ]; then
    echo "There is np answer." >&2
    exit 1
fi
if [ "$ANSWER" = "yes" ]; then
    echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
    echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
    echo "Then answer is MAYBE."
else
    echo "Then answer is UNKNOWW."
fi