(deftheme Spacemacs-ish
  "Created 2021-12-14.")

(custom-theme-set-variables
 'Spacemacs-ish
 ;; '(package-selected-packages '(csharp-mode which-key sudo-edit gnuplot gnuplot-mode pdf-tools dmenu mc-extras multiple-cursors slime-company slime company org xclip ##))
 )

(custom-theme-set-faces
 'Spacemacs-ish
 '(default ((((type x)) (:inherit nil :stipple nil :background "#292b2e" :foreground "#b2b2b2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "#e3dedd"))))
 '(highlight ((t (:background "#444444"))))
 '(message-header-subject ((t (:foreground "color-23" :weight bold))))
 '(message-header-to ((t (:foreground "color-23" :weight bold))))
 '(mode-line ((t (:background "#222226" :foreground "#f6f3e8" :box nil :height 1.0))))
 '(region ((t (:background "#444444"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#222226" :foreground "#857b6f" :box nil :weight light))))
 '(fringe ((t (:background "#292b2e")))))
;; mode-line-inactive alternate foreground "#b2b2b2"

(provide-theme 'Spacemacs-ish)
