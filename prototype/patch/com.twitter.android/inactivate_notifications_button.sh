#!/bin/bash

# smali file to modify
file=com/twitter/app/main/MainActivity.smali

ID=`perl -C -lne 'print for /<public type="id" name="notifications" id="(0x[0-9a-f]+)"/ig' "$1/res/values/public.xml"`

PATCH=$(cat <<-END
\ \ \ \ const v0, $ID\n\ \ \ \ invoke-virtual {p0, v0}, Lcom\/twitter\/app\/main\/MainActivity;->findViewById(I)Landroid\/view\/View;\n\ \ \ \ move-result-object v0\n\ \ \ \ const\/4 v1, 0x0\n\ \ \ \ invoke-virtual {v0, v1}, Landroid\/view\/View;->setOnClickListener(Landroid\/view\/View\$OnClickListener;)V\n\ \ \ \ invoke-virtual {v0, v1}, Landroid\/view\/View;->setOnTouchListener(Landroid\/view\/View\$OnTouchListener;)V\n
END
)

# Above Patch (0x7f0a0804 is 'notifications' ID):
#    const v0, 0x7f0a0804
#    invoke-virtual {p0, v0}, Lcom/twitter/app/main/MainActivity;->findViewById(I)Landroid/view/View;
#    move-result-object v0
#    const/4 v1, 0x0
#    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
#    invoke-virtual {v0, v1}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

# Additionally, one may want to add, to make notification icon invisible:
#    const/16 v2, 0x4
#    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

# find smali file in smali* folders
for dir in $1/*/; do
    if [[ "$dir" == $1/smali* ]]; then
        path="${dir}${file}"

        # check if file exists
        if [ -f $path ]; then
            echo "Patching file $path"

            line=1
            success=-1

            # read file line by line and identify insertion point
            while IFS="" read -r p || [ -n "$p" ]; do
                # find start of method
                if [[ $p == ".method protected onResume()V" ]]; then
                    success=0
                fi

                # find end of method
                if [[ $success == 0 ]] && [[ $p == ".end method" ]]; then
                    success=1
                    break
                fi

                line=$((line+1))
            done < $path

            if [[ $success != 1 ]]; then
                echo    "failure"
                exit 1
            fi

            # insert before 'return' statement
            insertion=$((line-1))

            sed -i "${insertion}i""${PATCH}""" $path

            echo "Patched at line $insertion"
        fi
    fi
done
