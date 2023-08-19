(use-modules
  (gnu)
  (gnu home)
  (gnu home services)
  (gnu packages freedesktop)
  (gnu packages)
  (gnu services)
  (guix channels)
  (guix gexp)
  (gnu home services shells)
  (gnu home services desktop)
  (gnu home services fontutils)
  (gnu home services guix))


(home-environment
  (packages
    (specifications->packages
      (list 
	;; -- wm stuff
	"sway"
	"swaybg"
	"swayidle"
	"swaylock"
	"fish"
	"grim"
	"foot"
	;; -- audio
	"pipewire"
	"wireplumber"
	"pulsemixer"
	"alsa-utils"
	;; -- gtk stuff
	"font-google-noto"
	"adwaita-icon-theme"
	"hicolor-icon-theme"
	"gsettings-desktop-schemas"
	"dconf"
	"xdg-desktop-portal"
	"xdg-desktop-portal-wlr"
	;; -- emacs
	"emacs-next-pgtk"
	"ffmpeg"
	"python-pip"
	;; -- browser
	"firefox-wayland"
	"intel-media-driver-nonfree"
	"libva-utils"
	;; -- images
	"imagemagick"
	;; -- vm
	"spice-gtk"
	"qemu"
	"ovmf"
	"samba"
	;; -- utils
	"fish-foreign-env"
	"htop"
	"unzip"
	"lm-sensors"
	"brightnessctl"
	"tmux"
	"file"
	"curl"
	"iproute2"
	"lsof"
	"xdot"
	;; -- development
	"make"
	"valgrind"
	"lld"
	"clang-toolchain"
	"git"
	"python"
	"gdb"
	;; -- music
	"mpd"
	"mpd-mpc")))
  (services
    (list
      (service home-xdg-configuration-files-service-type
	       (list `("sway/config"
		       ,(local-file "my_configs/sway.conf"))
		     `("foot/foot.ini"
		       ,(local-file "my_configs/foot.ini"))
		     `("mpd/mpd.conf"
		       ,(local-file "my_configs/mpd.conf"))
		     `("emacs/init.el"
		       ,(local-file "my_configs/emacs.el"))))
      (service home-fish-service-type
	       (home-fish-configuration
		 (config (list (local-file "my_configs/fish.fish")))
		 (environment-variables '(("FC_LANG" . "POSIX")))))
      (simple-service 'variant-packages-service
		      home-channels-service-type
		      (list
			(channel
			  (name 'nonguix)
			  (url "https://gitlab.com/nonguix/nonguix")
			  (introduction
			    (make-channel-introduction
			      "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
			      (openpgp-fingerprint
				"2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))))))
