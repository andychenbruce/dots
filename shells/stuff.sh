#!/bin/sh

guix shell --network --container --emulate-fhs \
	--pure \
	--no-cwd \
	--share=$HOME/shells/tmphome=$HOME \
	--manifest=manifest.scm \
	-- bash

