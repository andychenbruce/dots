#!/bin/sh

guix shell --network --container --emulate-fhs \
	--preserve='^TERM$' \
	--no-cwd \
	--share=$HOME/containers/tmphome=$HOME \
	--manifest=manifest.scm \
	-- bash

