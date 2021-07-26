#!/sbin/sh
#
##############################################################
# File name       : bitgapps.sh
#
# Description     : BiTGApps OTA survival script
#
# Copyright       : Copyright (C) 2018-2021 TheHitMan7
#
# License         : GPL-3.0-or-later
##############################################################
# The BiTGApps scripts are free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# These scripts are distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
##############################################################

# Set default
if [ -z $backuptool_ab ]; then TMP="/tmp"; else TMP="/postinstall/tmp"; fi

# Set busybox
BBDIR="/tmp"

# Always use busybox backup from /data
BBBAK="/data/busybox"

# Mount backup partitions
mount /cache > /dev/null 2>&1
mount /persist > /dev/null 2>&1
mount /metadata > /dev/null 2>&1

# Copy busybox backup
if [ -e "/cache/busybox/busybox-arm" ]; then
  cp -f /cache/busybox/busybox-arm $BBDIR/busybox-arm
fi
if [ -e "/persist/busybox/busybox-arm" ]; then
  cp -f /persist/busybox/busybox-arm $BBDIR/busybox-arm
fi
if [ -e "/metadata/busybox/busybox-arm" ]; then
  cp -f /metadata/busybox/busybox-arm $BBDIR/busybox-arm
fi

# Set runtime permission
[ -e "$BBDIR/busybox-arm" ] && chmod +x $BBDIR/busybox-arm

# Unmount backup partitions
umount /cache > /dev/null 2>&1
umount -l /cache > /dev/null 2>&1
umount /persist > /dev/null 2>&1
umount -l /persist > /dev/null 2>&1
umount /metadata > /dev/null 2>&1
umount -l /metadata > /dev/null 2>&1

# Run scripts in the busybox environment
case "$1" in
  backup)
    export ASH_STANDALONE=1
    # Set backuptool stage
    export RUN_STAGE_BACKUP="true"
    if [ -e "$BBDIR/busybox-arm" ]; then
      exec $BBDIR/busybox-arm sh "$TMP/addon.d/backup.sh" "$@"
    elif [ -e "$BBBAK/busybox-arm" ]; then
      exec $BBBAK/busybox-arm sh "$TMP/addon.d/backup.sh" "$@"
    else
      source "$TMP/addon.d/backup.sh" "$@"
    fi
  ;;
  restore)
    export ASH_STANDALONE=1
    # Set backuptool stage
    export RUN_STAGE_RESTORE="true"
    if [ -e "$BBDIR/busybox-arm" ]; then
      exec $BBDIR/busybox-arm sh "$TMP/addon.d/restore.sh" "$@"
    elif [ -e "$BBBAK/busybox-arm" ]; then
      exec $BBBAK/busybox-arm sh "$TMP/addon.d/restore.sh" "$@"
    else
      source "$TMP/addon.d/restore.sh" "$@"
    fi
  ;;
esac
