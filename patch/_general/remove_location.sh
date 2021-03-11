#!/bin/bash

cd $1
for f in `find . -name \*.smali -type f`; do
    perl -i -p0e 's/    [^\r\n]+Landroid\/location\/Location;->(getLongitude|getLatitude)\(\)D[\r\n]+    move-result-wide v([0-9]+)/"    const-wide\/16 v$2, 0x0"/seg' $f
done