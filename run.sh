#!/bin/sh
set -eu

if [ ! -e bash-1.14.7.tar.gz ]; then
  wget http://ftp.gnu.org/gnu/bash/bash-1.14.7.tar.gz
fi

docker build -t bash1.14 .
docker run --rm -it bash1.14
