#!/bin/bash
patch --forward $1/res/layout/view_fleetline.xml `dirname "$0"`/remove_status_updates.patch
