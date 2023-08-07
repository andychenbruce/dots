;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu)
	     (gnu home)
	     ;;(nongnu packages video)
	     (gnu packages freedesktop)
	     (gnu packages)
	     (gnu services)
	     (guix gexp)
	     (gnu home services shells)
	     (gnu home services desktop)
	     (gnu home services fontutils))
;;(use-package-modules freedesktop)

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list 
					;; -- wm stuff
					"sway"
					"swaybg"
					"swayidle"
					"swaylock"
					"grim"
					"alacritty"
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
					"xdg-desktop-portal"
					"xdg-desktop-portal-gtk"
					"xdg-desktop-portal-wlr"
					;; -- emacs
					"emacs-next-pgtk"
					;; -- yt-dlp
					"ffmpeg"
					"python-pip"
					;; -- browser
					"firefox-wayland"
					"intel-media-driver-nonfree"
					"libva-utils"
					;; -- images
					"imagemagick"
					;; -- vm
					"samba"
					"spice-gtk"
					"qemu"
					"ovmf"
					;; -- utils
					"fish-foreign-env"
					"man-pages"
					"lm-sensors"
					"brightnessctl"
					"tmux"
					"htop"
					"file"
					"unzip"
					"curl"
					"iproute2"
					"sshfs"
					"xdot"
					;; -- development
					"node"
					"cmake"
					"valgrind"
					"make"
					"clang"
					"lld"
					"gcc-toolchain"
					"git"
					"python"
					"gdb"
					;; -- music
					"mpd"
					"mpd-mpc"
					)))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
    (list
      (service home-fish-service-type
	       (home-fish-configuration
		 (config (list (plain-file "path-stuff" 
					   "set -x GUIX_PROFILE $HOME/.guix-profile\nset --prepend fish_function_path $HOME/.guix-home/profile/share/fish/functions/\nfenv source $HOME/.guix-profile/etc/profile\nfish_add_path -Pa ~/.local/bin\nset --export FC_LANG en_US.utf8")))
		(environment-variables '(("fish_greeting" . ""))))))))

