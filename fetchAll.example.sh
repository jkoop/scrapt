#! /bin/bash

# micro text editor
micro="https://github.com/zyedidia/micro/releases"
curl -s $micro | egrep -o '/zyedidia/micro/releases/download/v[^>]+\.deb' | wget --continue --quiet --show-progress --base=$micro --input-file=/dev/stdin
