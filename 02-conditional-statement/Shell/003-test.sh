#!/bin/bash

# 写法一
if  test -e ../02-conditional-statement/notes.md; then
    echo "Found notes.md"
fi

# 写法二
if [ -e ../02-conditional-statement/notes.md ]; then
    echo "Found notes.md"
fi

# 写法三
if [[ -e ../02-conditional-statement/notes.md ]]; then
    echo "Found notes.md"
fi