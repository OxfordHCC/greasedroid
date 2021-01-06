#!/bin/bash
patch $1/res/drawable/bg_unread_count_pill.xml `dirname "$0"`/4_remove_unread_notification_count_1.patch
patch $1/res/values/styles.xml `dirname "$0"`/4_remove_unread_notification_count_2.patch