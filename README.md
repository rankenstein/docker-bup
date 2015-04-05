Creates a backup using [bup](https://github.com/bup/bup) and saves it encrypted via FTP (using [curlftpfs](http://curlftpfs.sourceforge.net/) and [EncFS](https://github.com/vgough/encfs)).

Usage
=====

There are two modes. When passing a volume to be mounted in `/data`, the index/save mechanism of bup is used to create the backup:

```bash
docker create \
	--name "backup" \
	-e "FTP_URL=ftp://user:password@ftp.backupserver.com/directory"
	-e "ENCFS_PASSWORD=password"
	-e "BUP_NAME=backup"
	-v /directory/to/backup:/data
	--privileged
	rankenstein/bup-ftp

docker start -a backup
```

Otherwise, the split mechanism is used, which requires the data be be sent to stdin:

```bash
docker create -i \
	--name "backup" \
	-e "FTP_URL=ftp://user:password@ftp.backupserver.com/directory"
	-e "ENCFS_PASSWORD=password"
	-e "BUP_NAME=backup"
	--privileged
	rankenstein/bup-ftp

cat /file/to/backup | docker start -ai backup
```

Environment variables
---------------------

* `FTP_URL`: The FTP URL where to store the bup backup directory.
* `FTP_OPTIONS`: FTP options as passed to the [`-o` option of curlftpfs](http://linux.die.net/man/1/curlftpfs).
* `ENCFS_PASSWORD`: The password to use for EncFS encryption.
* `ENCFS_OPTIONS`: [EncFS options](https://github.com/vgough/encfs/blob/master/encfs/encfs.pod#options) (default: `--standard`)
* `BUP_NAME`: The branch name to use for the bup backup

Docker has to be run in privileged mode, as otherwise fuse is not usable.