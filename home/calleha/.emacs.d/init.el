;;;* Loading packages
;;;** package.el + melpa
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
;;;** org extensions
(use-package org-ref
  :init
  (autoload 'org-ref "org-ref" "org-ref" t)
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))
(use-package org-modern
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
; presentation mode turning org headlines into slides
(use-package org-present
  :init
  (use-package visual-fill-column)
  :config
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t)
  (add-hook 'org-present-mode-hook (lambda ()
  				     (visual-fill-column-mode 1)
  				     (display-line-numbers-mode -1)
  				     (visual-line-mode 1)))
  (add-hook 'org-present-mode-quit-hook (lambda ()
  				     (visual-fill-column-mode -1)
  				     (display-line-numbers-mode 1)
  				     (visual-line-mode -1))))
;;;** ai assistance - requires ollama with local llm, or working api key
(use-package gptel
  :config
  (setq gptel-default-mode 'org-mode)
  (setq gptel-model 'deepseek-r1:1.5b)
  (setq gptel-backend
  (gptel-make-ollama
   "Ollama"
   :host "localhost:11434"
   :models '("deepseek-r1" "deepseek-r1:1.5b""qwen2.5-coder:7b-instruct" "gemma2:latest" "gemma2:2b")
   :stream t)))
; ai code assistance with aider.el - requires aider
(use-package aider ;:ensure t
  :config
  (setq aider-args '("--model" "ollama_chat/deepseek-r1:1.5b" "--no-git")))
;;;** multiple-cursors, which-key, vertico, corfu
(use-package multiple-cursors)
(use-package which-key
  :config
  (which-key-mode 1))
(use-package vertico
  :config
  (vertico-mode 1))
(use-package corfu
  :config
  (global-corfu-mode 1))
;;;** pdf-view
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                   ,(face-attribute 'default :background)))
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode))
;;;** all the packages I forgot to add before
(use-package vterm)
(use-package sudo-edit)
(use-package avy)
(use-package god-mode)
(use-package zygospore :ensure t)
(use-package magit)
(use-package iedit)
(use-package gnuplot)
(use-package dmenu)
(use-package addressbook-bookmark :ensure t)
(use-package pinentry)
(use-package caps-lock)
;;;** emms
(use-package emms
  :init
  (emms-all)
  (setq emms-player-list '(emms-player-mpv)
        emms-info-functions '(emms-info-native)))
;;;** paredit
(use-package paredit
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
  (eldoc-add-command
   'paredit-backward-delete
   'paredit-close-round))

;;;* Settings
;;;** Functionality settings

; display lines
(global-display-line-numbers-mode)
;; relative visual line numbers
(setq display-line-numbers-type 'visual)
;; exceptions
(add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'vterm-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'eshell-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'shell-mode-hook (lambda () (display-line-numbers-mode -1)))

; wrap lines
(global-visual-line-mode 1)

; repeat mode
(repeat-mode 1)

; scroll line by line
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

; display time and battery
(setq display-time-24hr-format t)
(display-time-mode 1)
(display-battery-mode 1)

; disable startup screen
(setq inhibit-startup-screen t)

; disable ~files
(setq make-backup-files nil)

; enable dead keys
(require 'iso-transl)

; enable recursive minibuffers
(setq enable-recursive-minibuffers 1)

; ignore case in buffer completions
(setq read-buffer-completion-ignore-case 1)

;;;*** mail
(setq mail-host-address "disroot.org")
; outgoing
(setq send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "disroot.org"
      smtpmail-stream-type  'starttls
      smtpmail-smtp-service 587)
; incoming
(setq gnus-select-method
      '(nnimap "disroot.org"))

;;;** Aesthetics

; disable menu bar and other stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; remove fringes
;;(fringe-mode '(0 . 0))

;; colors (redundant; handled by themes)
;;(set-background-color "#292b2e")
;;(set-foreground-color "#b2b2b2")
;;(set-cursor-color "#e3dedd")

;; transparency
;;(set-frame-parameter (selected-frame) 'alpha 95)
;;(add-to-list 'default-frame-alist '(alpha 95))

;; blinking cursor
(blink-cursor-mode 1)

;; modeline
(column-number-mode 1)

;; font
;(add-to-list 'default-frame-alist
;               (cons 'font "Monaco:pixelsize=15"))

;;;* custom-set-variables
(setq custom-file "~/.emacs.d/custom-set-variables.el")
(load custom-file)

;;;* Custom functions

;;;** Editing
;; move to window when splitting
(defun split-window-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1))
(defun split-window-right-and-move ()
  (interactive)
  (split-window-right)
  (other-window 1))

;; kill-whole-word
(defun kill-whole-word ()
  (interactive)
  (forward-word)
  (backward-kill-word 1))

;; kill-whole-line
(defun kill-whole-line-custom ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line 1))

;; C-w for backward-kill-word, unless there is a region selected
(defadvice kill-region (before unix-werase activate compile)
      "When called interactively with no active region, delete a single word
    backwards instead."
      (interactive
       (if mark-active (list (region-beginning) (region-end))
         (list (save-excursion (backward-word 1) (point)) (point)))))

;; copy line, or copy region if there is a region selected
(defun kill-ring-save-line-or-region (beg end)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position) (line-beginning-position 2))))
  (kill-ring-save beg end))

;; kill all buffers
(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;; kill the current buffer
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

;;;** Linux/X11
;; set keyboard layout
(defun setkeyboardlayout ()
  (interactive)
  (start-process "" nil "setxkbmap" "-layout" (completing-read "choose layout " '("us" "us -variant alt-gr-intl" "us -variant intl" "se" "fr" "el -variant polytonic" "es -variant cat" "ara -variant buckwalter"))))
(defun global-caps-lock-mode ()
  (interactive)
  (start-process "" nil "xdotool" "key" "Caps_Lock"))
(defun power-menu () ; unfinished
  (interactive)
  (defvar power-menu-option (completing-read "choose action " '("lock" "hibernate" "sleep" "log out" "reboot" "power off")))
  (when (= power-menu-option '("lock"))
    (start-process "" nil "slock"))
  (when (= power-menu-option '"hibernate")
    (start-process "" nil "systemctl" "hibernate"))
  (when (= power-menu-option '"sleep")
    (start-process "" nil "systemctl" "suspend"))
  (when (= power-menu-option '"log out")
    (defvar power-menu-tty (completing-read "which tty? " '("tty1" "tty2" "tty3" "tty4" "tty5" "tty6")))
    )
  )

;; launch programs and scripts
(defun start-process-trackpoint-configuration ()
  (interactive)
  (async-shell-command "sudo ~/.local/bin/trackpoint_configuration.sh"))
(defun start-process-firefox ()
  (interactive)
  (start-process "" nil "icecat"))
(defun start-process-firefox-private-window ()
  (interactive)
  (start-process "" nil "icecat" "--private-window"))
(defun start-process-passmenu-type ()
  (interactive)
  (start-process-shell-command "" nil "passmenu --type -l 16 -b"))
(defun start-process-nautilus ()
  (interactive)
  (start-process "" nil "nautilus"))
(defun start-process-unclutter-5s ()
  (interactive)
  (start-process-shell-command "" nil "unclutter -idle 5 -root"))
(defun start-process-picom-vsync ()
  (interactive)
  (start-process-shell-command "" nil "picom --backend glx --vsync"))
(defun exwm-startup-configuration ()
  (interactive)
  (start-process-shell-command "" nil "xhost +SI:localuser:$USER")
  (start-process-shell-command "" nil "export _JAVA_AWT_WM_NONREPARENTING=1")
  (start-process-shell-command "" nil "xsetroot -cursor_name left_ptr"))

;; volume controls
(defun toggle-mute ()
  (interactive)
  (start-process-shell-command "" nil "amixer -q set Master toggle"))
(defun volume-up ()
  (interactive)
  (start-process-shell-command "" nil "amixer -q set Master 1%+"))
(defun volume-down ()
  (interactive)
  (start-process-shell-command "" nil "amixer -q set Master 1%-"))

;; screenshots
(defun capture-screenshot ()
  (interactive)
  (start-process-shell-command "" nil "import -window root ~/Pictures/screenshots/screenshot_$(date '+%Y-%m-%d_%H:%M')_$(echo $RANDOM).png"))
(defun capture-screenshot-crop ()
  (interactive)
  (start-process-shell-command "" nil "import ~/Pictures/screenshots/screenshot_$(date '+%Y-%m-%d_%H:%M')_$(echo $RANDOM).png"))

;; set keyboard repeat rate and disable system beep
(defun start-process-xset-kbrate-200-60 ()
  (interactive)
  (start-process-shell-command "" nil "xset r rate 200 60"))
(defun start-process-xset-kbbeep-off ()
  (interactive)
  (start-process-shell-command "" nil "xset b off"))
;; disable screen saver
(defun start-process-xset-s-off-dpms ()
  (interactive)
  (start-process-shell-command "" nil "xset s off -dpms"))

;; setkeyboardlayout-default (us ctrl:nocaps)
(defun start-process-setkeyboardlayout-default ()
  (interactive)
  (start-process-shell-command "" nil "setxkbmap -layout us -option ctrl:nocaps"))

;; setkeyboardlayout-swapped
;; Left Alt as Ctrl, Left Ctrl as Win, Left Win as Left Alt
;; Swap Right Alt with Right Ctrl
;; Make Caps Lock an additional Hyper
(defun start-process-setkeyboardlayout-swapped ()
  (interactive)
  (start-process-shell-command "" nil "setxkbmap -layout us -option ctrl:swap_lalt_lctl_lwin -option ctrl:swap_ralt_rctl -option caps:hyper"))

;; touchpad-enable-natural-scrolling
(defun start-process-touchpad-enable-natural-scrolling ()
  (interactive)
  (start-process-shell-command "" nil "xinput set-prop 'Elan Touchpad' 'libinput Natural Scrolling Enabled' 1"))

;; print-keyboard-layout-options
(defun print-keyboard-layout-options ()
  (interactive)
  (async-shell-command "grep -E '(ctrl|alt|win|caps):' /usr/share/X11/xkb/rules/base.lst"))

;; enable hyper if disabled by OS
(defun enable-hyper ()
  (interactive)
  (start-process-shell-command "" nil "xmodmap -e 'remove mod4=Hyper_L'")
  (start-process-shell-command "" nil "xmodmap -e 'add mod3=Hyper_L'"))

;;;* Custom keybindings

;; general
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "H-0") 'delete-window)
(global-set-key (kbd "H-1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "H-2") 'split-window-below)
(global-set-key (kbd "H-3") 'split-window-right)
(global-set-key (kbd "H-4") 'ctl-x-4-prefix)
(global-set-key (kbd "H-5") 'ctl-x-5-prefix)
(global-set-key (kbd "H-o") 'other-window)
(global-set-key (kbd "H-x 2") 'split-root-window-below)
(global-set-key (kbd "H-x 3") 'split-root-window-right)
(global-set-key (kbd "H-x d") 'toggle-window-dedicated)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "C-<tab>") 'next-buffer)
(global-set-key (kbd "s-<tab>") 'previous-buffer)
(global-set-key (kbd "H-<tab>") 'switch-to-buffer)
(global-set-key (kbd "H-k") 'kill-paragraph)
(global-set-key (kbd "H-w") 'backward-kill-paragraph)
(global-set-key (kbd "H-y") 'duplicate-line)
(global-set-key (kbd "H-u") 'undo)
(global-set-key (kbd "H-x H-e") 'eval-region)

;; calling custom functions
(global-set-key (kbd "C-x C-2") 'split-window-below-and-move)
(global-set-key (kbd "C-x C-3") 'split-window-right-and-move)
(global-set-key (kbd "H-x k") 'kill-current-buffer)
(global-set-key (kbd "H-d") 'kill-whole-word)
(global-set-key (kbd "C-c C-l") 'kill-whole-line-custom)
(global-set-key (kbd "M-w") 'kill-ring-save-line-or-region)
(global-set-key (kbd "C-s-x C-s-k") 'kill-all-buffers)

;; (org-mode) The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; modes and command shortcuts
(global-set-key (kbd "M-<return>") 'eshell)
(global-set-key (kbd "H-<return>") 'async-shell-command)
(global-set-key (kbd "C-c m") 'compile)
(global-set-key (kbd "C-c g") 'gnus)
(global-set-key (kbd "C-c q") 'visual-line-mode)
(global-set-key (kbd "C-c e") 'electric-pair-mode)
(global-set-key (kbd "C-c n") 'display-line-numbers-mode)
(global-set-key (kbd "C-c C-b") 'menu-bar-mode)
(global-set-key (kbd "C-c t") 'global-tab-line-mode)
;; agenda and notifications
(global-set-key (kbd "C-c r") 'appt-activate)
(global-set-key (kbd "H-a t") 'appt-activate)
(global-set-key (kbd "H-a a") 'org-agenda-list)
(global-set-key (kbd "C-c C-r") 'org-agenda-to-appt)
(global-set-key (kbd "H-a H-s") 'org-agenda-to-appt)
(global-set-key (kbd "H-a H-a") 'org-cycle-agenda-files)

; keybindings for extensions
(global-set-key (kbd "H-<") 'caps-lock-mode)
(global-set-key (kbd "C-c d") 'pdf-view-midnight-minor-mode)
(global-set-key (kbd "C-c p") 'org-present)
(global-set-key (kbd "C-<return>") 'vterm)
(global-set-key (kbd "s-x") 'dmenu)
(global-set-key (kbd "H-<escape>") #'god-local-mode)
(global-set-key (kbd "H-c g") 'gptel)
(global-set-key (kbd "H-c a") 'aider-transient-menu)
;; multiple-cursors
(global-set-key (kbd "C-. C-.") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-. C-<") 'mc/mark-all-like-this)
;; avy
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-c C-;") 'avy-goto-word-1)
;; emms
(global-set-key (kbd "C-c <right>") 'emms-next)
(global-set-key (kbd "C-c <left>") 'emms-previous)
(global-set-key (kbd "C-c <down>") 'emms-pause)
(global-set-key (kbd "C-c <up>") 'emms-play-directory)

; keybindings for linux/x11 stuff
;; general
(global-set-key (kbd "s-SPC") 'setkeyboardlayout)
(global-set-key (kbd "H-SPC") 'guix)
(global-set-key (kbd "H-`") 'global-caps-lock-mode)

;; launch programs and scripts
(global-set-key (kbd "s-m") 'start-process-nautilus)
(global-set-key (kbd "s-c") 'start-process-passmenu-type)
(global-set-key (kbd "s-f") 'start-process-firefox)
(global-set-key (kbd "C-s-f") 'start-process-firefox-private-window)

;; volume controls
(global-set-key (kbd "M-s-m") 'toggle-mute)
(global-set-key (kbd "s-p") 'volume-up)
(global-set-key (kbd "s-n") 'volume-down)

;; screenshots
(global-set-key (kbd "s-s") 'capture-screenshot)
(global-set-key (kbd "M-s-s") 'capture-screenshot-crop)

;;;* Macros

;; Open Inbox
;(fset 'inbox
;   [?\C-c ?m ?\C-s ?i ?n ?b ?o ?x return ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b return])
;(global-set-key (kbd "C-c i") 'inbox)

;;;* Outline mode in init.el
(add-hook 'emacs-lisp-mode-hook 
          (lambda ()
            (make-local-variable 'outline-regexp)
            (setq outline-regexp ";;;\\*+\\|\\`")
            (make-local-variable 'outline-heading-end-regexp)
            (outline-minor-mode 1)
            ))

;;;* EXWM
(use-package exwm
:config
(require 'exwm)

;; Set the initial number of workspaces (they can also be created later).
(setq exwm-workspace-number 1)

;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;; are run when a new X window class name or title is available.  Here's
;; some advice on this topic:
;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;; + For applications with multiple windows (e.g. GIMP), the class names of
;    all windows are probably the same.  Using window titles for them makes
;;   more sense.
;; In the following example, we use class names for all windows except for
;; Java applications and GIMP.
(add-hook 'exwm-update-class-hook
          (lambda ()
            (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                        (string= "gimp" exwm-instance-name))
              (exwm-workspace-rename-buffer exwm-class-name))))
(add-hook 'exwm-update-title-hook
          (lambda ()
            (when (or (not exwm-instance-name)
                      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                      (string= "gimp" exwm-instance-name))
              (exwm-workspace-rename-buffer exwm-title))))

;; Global keybindings can be defined with `exwm-input-global-keys'.
;; Here are a few examples:
(setq exwm-input-global-keys
      `(
        ;; Bind "s-r" to exit char-mode and fullscreen mode.
        ([?\s-r] . exwm-reset)
        ;; Bind "s-w" to switch workspace interactively.
        ([?\s-w] . exwm-workspace-switch)
        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))
        ;; Bind "s-&" to launch applications ('M-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))
        ;; Bind "s-<f2>" to "slock", a simple X display locker.
        ([s-f2] . (lambda ()
		    (interactive)
		    (start-process "" nil "slock")))
	;; Bind "s-x" to dmenu_run
	([?\s-x] . dmenu)
	;; Bind "s-<escape>" to power menu
	([s-escape] . (lambda ()
		     (interactive)
		     (start-process-shell-command "" nil "~/.local/bin/power.sh")))
	))

;; To add a key binding only available in line-mode, simply define it in
;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
(define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
(define-key exwm-mode-map (kbd "H-0") 'delete-window)
(define-key exwm-mode-map (kbd "H-1") 'zygospore-toggle-delete-other-windows)
(define-key exwm-mode-map (kbd "H-2") 'split-window-below)
(define-key exwm-mode-map (kbd "H-3") 'split-window-right)
(define-key exwm-mode-map (kbd "H-4") 'ctl-x-4-prefix)
(define-key exwm-mode-map (kbd "H-5") 'ctl-x-5-prefix)
(define-key exwm-mode-map (kbd "H-o") 'other-window)
(define-key exwm-mode-map (kbd "H-x 2") 'split-root-window-below)
(define-key exwm-mode-map (kbd "H-x 3") 'split-root-window-right)
(define-key exwm-mode-map (kbd "H-x d") 'toggle-window-dedicated)
(define-key exwm-mode-map (kbd "C-<tab>") 'next-buffer)
(define-key exwm-mode-map (kbd "s-<tab>") 'previous-buffer)
(define-key exwm-mode-map (kbd "H-<tab>") 'switch-to-buffer)
(define-key exwm-mode-map (kbd "H-x k") 'kill-current-buffer)
(define-key exwm-mode-map (kbd "C-<return>") 'vterm)
(define-key exwm-mode-map (kbd "M-<return>") 'eshell)
(define-key exwm-mode-map (kbd "H-<return>") 'async-shell-command)
(define-key exwm-mode-map (kbd "C-c C-f") 'exwm-layout-toggle-fullscreen)
(define-key exwm-mode-map (kbd "s-m") 'start-process-nautilus)
(define-key exwm-mode-map (kbd "s-SPC") 'setkeyboardlayout)
(define-key exwm-mode-map (kbd "H-SPC") 'guix)
(define-key exwm-mode-map (kbd "H-`") 'global-caps-lock-mode)
(define-key exwm-mode-map (kbd "s-c") 'start-process-passmenu-type)
(define-key exwm-mode-map (kbd "s-f") 'start-process-firefox)
(define-key exwm-mode-map (kbd "C-s-f") 'start-process-firefox-private-window)
(define-key exwm-mode-map (kbd "M-s-m") 'toggle-mute)
(define-key exwm-mode-map (kbd "s-p") 'volume-up)
(define-key exwm-mode-map (kbd "s-n") 'volume-down)
(define-key exwm-mode-map (kbd "s-s") 'capture-screenshot)
(define-key exwm-mode-map (kbd "M-s-s") 'capture-screenshot-crop)

;; The following example demonstrates how to use simulation keys to mimic
;; the behavior of Emacs.  The value of `exwm-input-simulation-keys` is a
;; list of cons cells (SRC . DEST), where SRC is the key sequence you press
;; and DEST is what EXWM actually sends to application.  Note that both SRC
;; and DEST should be key sequences (vector or string).
(setq exwm-input-simulation-keys
      '(
        ;; movement
        ([?\C-b] . [left])
        ([?\M-b] . [C-left])
        ([?\C-f] . [right])
        ([?\M-f] . [C-right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end delete])
	([?\C-g] . [escape])
	([?\C-j] . [return])
        ;; cut/paste.
        ([?\C-w] . [?\C-x])
        ([?\M-w] . [?\C-c])
        ([?\C-y] . [?\C-v])
        ;; search
        ([?\C-s] . [?\C-f])))

;; You can hide the minibuffer and echo area when they're not used, by
;; uncommenting the following line.
;(setq exwm-workspace-minibuffer-position 'bottom)

;; Open ediff control panel in a new window instead of a new frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Multiple screens with xrandr
(exwm-randr-mode 1)

;; exwm-modeline
(use-package exwm-modeline :ensure t
  :config
  (exwm-modeline-mode 1))

;; autostart linux programs
(start-process-xset-kbrate-200-60)
(start-process-xset-kbbeep-off)
(start-process-xset-s-off-dpms)
(start-process-setkeyboardlayout-swapped)
;(enable-hyper)
(start-process-touchpad-enable-natural-scrolling)
(start-process-unclutter-5s)
(start-process-picom-vsync)
(exwm-startup-configuration)

;; launch exwm
(exwm-enable))
