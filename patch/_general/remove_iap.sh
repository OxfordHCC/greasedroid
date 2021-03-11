#!/bin/bash

cd $1
for f in `find . -name \*.smali -type f`; do
    if grep -q IInAppBillingService "$f"; then
        echo $f
        #sed -i '/"com\.android\.vending\.billing\.IInAppBillingService"/a \ \ \ \ return-void' $f
        sed -i 's/com\.android\.vending\.billing\.IInAppBillingService/com\.android\.vending\.billing\.IInAppBillingService2/' $f
    fi
done
