(use-modules
 (gnu)
 (gnu home)
 (gnu home services)
 (gnu packages)
 (guix channels)
 (gnu home services shells)
 (gnu home services desktop)
 (gnu home services guix)
 (gnu home services sound)
 (gnu home services xdg))

(define andys_home
  (home-environment
   (packages
    (specifications->packages
     (list
      ;; -- wm stuff
      "sway"
      "swaybg"
      "swayidle"
      "swaylock"
      ;; -- portals
      "xdg-desktop-portal"
      "xdg-desktop-portal-wlr"
      "xdg-desktop-portal-gtk"
      "at-spi2-core"
      ;; -- screenshot
      "grim"
      "slurp"
      ;; -- wechat
      ;; https://github.com/web1n/wechat-universal-flatpak
      "flatpak"
      ;; -- audio
      "pipewire"
      "wireplumber"
      ;; -- fonts
      "font-google-noto"
      "font-google-noto-emoji"
      "font-google-noto-sans-cjk"
      "font-google-noto-serif-cjk"
      ;; -- icons
      "adwaita-icon-theme"
      "hicolor-icon-theme"
      ;; -- emacs
      "emacs-next-pgtk"
      ;; -- browser
      "firefox"
      "intel-media-driver-nonfree"
      ;; -- conatiners
      "podman"
      "slirp4netns"
      ;; -- shell
      "fish"
      "fish-foreign-env"
      ;; -- utils
      "file"
      "curl"
      "iproute2"
      "lm-sensors"
      "python"
      "brightnessctl"
      ;; -- vcs
      "git"
      "git-lfs"
      ;; -- media
      "imagemagick"
      "ffmpeg"
      ;; "mpd"
      ;; "mpd-mpc"
      )))
   (services
    (list
     (service home-dbus-service-type)
     (service home-pipewire-service-type)
     (service home-xdg-configuration-files-service-type
	      (list `("sway/config"
		      ,(local-file "my_configs/sway/config"))
		    `("mpd/mpd.conf"
		      ,(local-file "my_configs/mpd/mpd.conf"))
		    `("emacs/init.el"
		      ,(local-file "my_configs/emacs/init.el"))
		    `("fish/config.fish"
		      ,(local-file "my_configs/fish/fish.fish"))))
     (service home-xdg-user-directories-service-type
	      (home-xdg-user-directories-configuration
	       (desktop     "$HOME/桌面")
	       (documents   "$HOME/文档")
	       (download    "$HOME/下载")
	       (music       "$HOME/音乐")
	       (pictures    "$HOME/图片")
	       (publicshare "$HOME/公共")
	       (templates   "$HOME/模板")
	       (videos      "$HOME/视频")))
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
			  "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))))))))
(home-environment
 (inherit andys_home)
 (essential-services
  (modify-services
   (home-environment-essential-services andys_home)
   (delete home-shell-profile-service-type))))
