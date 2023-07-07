#!/bin/sh

guix shell --network --container --emulate-fhs \
	--preserve='^TERM$' \
	--no-cwd \
	nss-certs \
	bash coreutils curl grep sed gawk make cmake findutils \
	libgccjit gmp openssl \
	gcc-toolchain:static gcc-toolchain glibc-locales pkg-config clang \
	ncurses ncurses-with-tinfo \
	neovim tmux openssl:static \
	sqlite \
	valgrind gdb \
	openssh git \
	util-linux coreutils htop wget procps less \
	tar gzip xz \
	--share=$HOME/containers/tmphome=$HOME -- bash

