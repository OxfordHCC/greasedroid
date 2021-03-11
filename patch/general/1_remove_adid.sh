#!/bin/bash

cd $1
for f in `find . -name \*.smali -type f`; do
    if grep -q "com\.google\.android\.gms\.ads\.identifier\.service" "$f"; then
        echo $f
        #sed -i '/"com\.google\.android\.gms\.ads\.identifier\.internal\.IAdvertisingIdService"/a \ \ \ \ return-void' $f
        sed -i 's/com\.google\.android\.gms\.ads\.identifier\.service/com\.google\.android\.gms\.ads\.identifier\.services/' $f
    fi
done