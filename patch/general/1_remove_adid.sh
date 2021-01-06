#!/bin/bash

cd $1
for f in `find . -name \*.smali -type f`; do
    sed -i '/"com\.google\.android\.gms\.ads\.identifier\.internal\.IAdvertisingIdService"/a \ \ \ \ return-void' $f
done