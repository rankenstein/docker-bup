Creates a backup using [bup](https://github.com/bup/bup).

Usage
=====

There are two modes. When passing a volume to be mounted in `/data`, the index/save mechanism of bup is used to create the backup:

```bash
docker create \
	--name "backup" \
	-e "BUP_NAME=backup"
	-v /directory/to/backup:/data
	rankenstein/bup

docker start -a backup
```

Otherwise, the split mechanism is used, which requires the data be be sent to stdin:

```bash
docker create -i \
	--name "backup" \
	-e "BUP_NAME=backup"
	rankenstein/bup

cat /file/to/backup | docker start -ai backup
```

Environment variables
---------------------

* `BUP_NAME`: The branch name to use for the bup backup (default: `backup`)

Volumes
-------

* `/data`: The data that should be backed up
* `/backup`: The backup will be saved here