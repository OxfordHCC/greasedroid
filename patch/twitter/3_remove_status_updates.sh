#!/bin/bash
patch $1/res/layout/view_fleetline.xml `dirname "$0"`/3_remove_status_updates.patch
