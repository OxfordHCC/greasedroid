#!/bin/bash
patch --forward $1/res/drawable/bg_unread_count_pill.xml `dirname "$0"`/remove_unread_notification_count_1.patch
sed -i 's~<item name="numberTextSize">@dimen/font_size_xxsmall</item>~<item name="numberTextSize">1\.0sp</item>~g' $1/res/values/styles.xml