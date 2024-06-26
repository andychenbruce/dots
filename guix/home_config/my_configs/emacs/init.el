(custom-set-variables
 '(custom-enabled-themes '(modus-operandi))
 '(default-input-method "chinese-tonepy-punct")
 '(eldoc-echo-area-use-multiline-p nil)
 '(fido-vertical-mode t)
 '(inhibit-startup-screen t)
 '(major-mode-remap-alist
   '((sh-mode . bash-ts-mode)
     (js-json-mode . json-ts-mode)
     (javascript-mode . js-ts-mode)
     (python-mode . python-ts-mode)
     (conf-toml-mode . toml-ts-mode)
     (css-mode . css-ts-mode)
     (c-mode . c-ts-mode)
     (c++-mode . c++-ts-mode)
     (c-or-c++-mode . c-or-c++-ts-mode)))
 '(menu-bar-mode nil)
 '(mpc-songs-format "%-5{Time} %200{Title}")
 '(newsticker-url-list-defaults nil)
 '(pixel-scroll-precision-mode t)
 '(scroll-bar-mode nil)
 '(term-mode-hook '(lambda nil (toggle-truncate-lines 1)))
 '(tool-bar-mode nil)
 '(tramp-remote-path '(tramp-own-remote-path) nil 'tramp)
 '(treesit-font-lock-level 4))
(setq auto-mode-alist
      (append '(("\\.rs\\'" . rust-ts-mode))
	      '(("\\.tsx\\'" . tsx-ts-mode))
	      '(("\\.ts\\'" . typescript-ts-mode))
	      '(("\\.yml\\'" . yaml-ts-mode))
	      '(("\\CMakeLists.txt\\'" . cmake-ts-mode))
	      '(("\\Dockerfile\\'" . dockerfile-ts-mode))
              auto-mode-alist))
