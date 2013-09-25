#!/bin/bash

test "$1" && ronn $1 && mv -f ${1/.md/}.1.html ${1/.md/}.html && exit 0

for file in $(ls git*.md); do
  extra=${file/.md/}
  ronn $file && mv -f $extra.1.html $extra.html
done
