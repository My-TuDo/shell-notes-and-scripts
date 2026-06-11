#!/bin/bash

declare -r USER="foo"

if test $USER = "foo";then
    echo "Hello foo."
else
    echo "You are not foo."
fi
