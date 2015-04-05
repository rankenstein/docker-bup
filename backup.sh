#!/bin/bash
[ -z "$FTP_URL" ] && echo "No FTP_URL specified." && exit 1
[ -z "$PASSWORD" ] && echo "No PASSWORD specified." && exit 1
[ -z "$BUP_NAME" ] && echo "No BUP_NAME specified." && exit 1

curlftpfs -o "$FTP_OPTIONS" "$FTP_URL" /mnt/ftp || exit $?

echo "$PASSWORD" | encfs --stdinpass "$ENCFS_OPTIONS" /mnt/ftp /mnt/enc || exit $?

export BUP_DIR=/mnt/enc
[ ! -e /mnt/enc/objects ] && bup init || exit $?

if [ -e /data ]; then
	bup index /data || exit $?
	bup save -n "$BUP_NAME" /data || exit $?
else
	bup split -n "$BUP_NAME" || exit $?
fi