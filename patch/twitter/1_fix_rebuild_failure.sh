#!/bin/bash

# Fix error with recompiling in apktool
# Remove splits from AndroidManifest.xml
sed -i '/<meta-data android:name="com\.android\.vending\.splits"/d' $1/AndroidManifest.xml