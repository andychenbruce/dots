(use-modules
 (gnu)
 (gnu home)
 (gnu home services)
 (gnu packages)
 (gnu services)
 (guix channels)
 (guix gexp)
 (gnu home services shells)
 (gnu home services desktop)
 (gnu home services fontutils)
 (gnu home services guix)
 (gnu home services xdg))

(home-environment
 (packages
  (specifications->packages
   (list
    ;; -- wm stuff
    "sway"
    "swaybg"
    "swayidle"
    "swaylock"
    "gammastep"
    "grim"
    "slurp"
    "alacritty"
    "wl-clipboard"
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
    "xdg-desktop-portal"
    "xdg-desktop-portal-wlr"
    "gtk"  ;;gtk4 schemas
    "gtk+" ;;gtk3 schemas
    ;; -- emacs
    "emacs-pgtk"
    ;; -- browser
    "firefox-wayland"
    "intel-media-driver-nonfree"
    "libva-utils"
    ;; -- images
    "imagemagick"
    ;; -- vm
    "virt-viewer"
    "qemu"
    "ovmf"
    ;; -- shell
    "fish-foreign-env"
    "fish"
    "kakoune"
    "exa"
    "bat"
    "fd"
    "du-dust"
    "ripgrep"
    ;; -- utils
    "ffmpeg"
    "lm-sensors"
    "brightnessctl"
    "file"
    "curl"
    "unzip"
    "zstd"
    "lsof"
    "xdot"
    "iproute2"
    "git"
    "git-lfs"
    "python"
    "python-pip"
    "smartmontools"
    ;; -- docker
    "docker"
    "containerd"
    "docker-cli"
    ;; -- music
    "mpd"
    "mpd-mpc")))
 (services
  (list
   (service home-xdg-configuration-files-service-type
	    (list `("sway/config"
		    ,(local-file "my_configs/sway/config"))
		  `("mpd/mpd.conf"
		    ,(local-file "my_configs/mpd/mpd.conf"))
		  `("zellij/config.kdl"
		    ,(local-file "my_configs/zellij/config.kdl"))
		  `("zellij/layouts/default.kdl"
		    ,(local-file "my_configs/zellij/layouts/default.kdl"))
		  `("emacs/init.el"
		    ,(local-file "my_configs/emacs/init.el"))
		  `("alacritty/alacritty.yml"
		    ,(local-file "my_configs/alacritty/alacritty.yml"))))
   (service home-xdg-user-directories-service-type
	    (home-xdg-user-directories-configuration
	     (desktop     "$HOME/桌面")
	     (documents   "$HOME/文档")
	     (download    "$HOME/下载")
	     (music       "$HOME/.mpd/音乐")
	     (pictures    "$HOME/图片")
	     (publicshare "$HOME/公共")
	     (templates   "$HOME/模板")
	     (videos      "$HOME/视频")))
   (service home-fish-service-type
	    (home-fish-configuration
	     (config (list (local-file "my_configs/fish_startup.fish")))
	     (environment-variables '(("FC_LANG" . "POSIX")
				      ("VISUAL" . "emacs")))))
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
