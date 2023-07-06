;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
	     (gnu packages)
	     (gnu services)
	     (guix gexp)
	     (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list 
				      ;; -- wm stuff
				      "sway"
				      "swaybg"
				      "swayidle"
				      "swaylock"
				      "foot"
				      ;; -- audio
				      "pipewire"
				      "wireplumber"
				      "alsa-utils"
				      "pulsemixer"
				      ;; -- gtk stuff
				      "font-google-noto"
				      "font-gnu-unifont"
				      "adwaita-icon-theme"
				      "gsettings-desktop-schemas"
				      ;; -- emacs
				      "emacs-next-pgtk"
				      ;; -- yt-dlp
				      "ffmpeg"
				      "python-pip"
				      ;; -- browser
				      "firefox-wayland"
				      ;; -- images
				      "imagemagick"
				      ;; -- vm
				      "samba"
				      "spice-gtk"
				      "qemu"
				      "ovmf"
				      ;; -- utils
				      "man-pages"
				      "lm-sensors"
				      "brightnessctl"
				      "node"
				      "tmux"
				      "htop"
				      "file"
				      "unzip"
				      "curl"
				      "nethogs"
				      ;; -- development
				      "valgrind"
				      "make"
				      "clang"
				      "gcc-toolchain"
				      "gcc-toolchain:static"
				      "git"
				      "python"
				      "gdb"
				      ;; -- music
				      "mpd"
				      "ncmpcpp"
				      )))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
		 (home-bash-configuration
		  (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
			     ("ls" . "ls -p --color=auto")))
		  (bashrc (list (local-file
				 "/home/pooman123/home_config/.bashrc"
				 "bashrc")))
		  (bash-profile (list (local-file
				       "/home/pooman123/home_config/.bash_profile"
				       "bash_profile")))))
	(service home-fish-service-type
		 (home-fish-configuration
		  (environment-variables '(("fish_greeting" . "")))
		  (config (list (plain-file "path-stuff" "fish_add_path -Pa ~/.local/bin")))
		  ))
	)))
