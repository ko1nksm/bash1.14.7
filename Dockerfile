## No gcc patch required.
FROM debian/eol:potato
# FROM debian/eol:woody

## gcc patch required.
# FROM debian/eol:sarge
# FROM debian/eol:etch
# FROM debian/eol:lenny
# FROM debian/eol:squeeze
# FROM debian/eol:wheezy
# FROM debian/eol:jessie  # The apt sources.list needs to be updated.
# FROM debian/eol:stretch # The apt sources.list needs to be updated.
# FROM debian:buster

## Build fails.
# FROM debian:bullseye

RUN apt-get update \
 && apt-get install -y make gcc patch less libc-dev libncurses5-dev
RUN apt-get install -y csh tcsh
WORKDIR /root
COPY bash-1.14.7.tar.gz /root
RUN tar zxvf bash-1.14.7.tar.gz

# Patch to compile with newer versions of gcc
# Taken from https://www.lukeshu.com/blog/build-bash-1.html
COPY patch/* /root
RUN for i in *.patch; do patch -p0 < "$i"; done

RUN cd bash-1.14.7 && make install
RUN echo 'PS1="\$BASH_VERSION:\w\$ "' >> .bashrc
RUN ln -s /usr/local/bin/bash /usr/local/bin/bash1
RUN ln -s /bin/bash /usr/local/bin/bash2
