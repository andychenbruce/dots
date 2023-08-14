guix shell --network --container --emulate-fhs \
	--pure \
	--no-cwd \
	--preserve="^TERM\$" \
	--preserve="^LANG\$" \
	--share=$HOME/shells/tmphome=$HOME \
	--manifest=manifest.scm \
	-- bash --init-file ~/setup.sh
