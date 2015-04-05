FROM debian:7
MAINTAINER Candid Dauth <cdauth@cdauth.eu>

RUN apt-get update && apt-get install -y \
	bup \
	curlftpfs \
	encfs

RUN mkdir /mnt/{ftp,enc} /data

COPY ./backup.sh /usr/local/bin/backup.sh

CMD "backup.sh"