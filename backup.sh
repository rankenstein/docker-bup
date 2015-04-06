#!/bin/bash
[ -z "$BUP_NAME" ] && BUP_NAME="backup"

export BUP_DIR=/mnt/enc
[ ! -e /mnt/enc/objects ] && bup init || exit $?

if [ -e /data ]; then
	bup index /data || exit $?
	bup save -n "$BUP_NAME" /data || exit $?
else
	bup split -n "$BUP_NAME" || exit $?
fi