(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ai-code-onboarding-seen t)
 '(ai-code-opencode-program "~/.local/bin/opencode")
 '(auth-source-save-behavior nil)
 '(custom-enabled-themes '(Spacemacs-ish))
 '(custom-safe-themes
   '("09df676b50ab963e0475a17381cf6b4759063b70cd8a86e980db80ff8456f8f7"
     "5ea9e2081d3f0085eb88b91ad2061ad4c71c56e97b4d933c1e923fdc7b9fd342"
     "67a817ac588945bb249a0979e8f733758291267b6e7b1da0f1f969038c74cf02"
     "a5ce5375c00fec65089ddf30977049c6bf327ce9a38fac27d43f3b08bdc87549"
     default))
 '(org-agenda-custom-commands
   '(("2" "Agenda for two weeks" agenda "" ((org-agenda-span 'fortnight)))
     ("n" "Agenda and all TODOs" ((agenda "" nil) (alltodo "" nil))
      nil)))
 '(org-agenda-files '("/home/calleha/Documents/reminders.org"))
 '(org-export-backends '(ascii beamer html icalendar latex odt))
 '(org-export-with-toc nil)
 '(package-selected-packages
   '(## addressbook-bookmark ai-code aider avy bluetooth caps-lock corfu
	dmenu emms exwm exwm-modeline gnu-elpa-keyring-update gnuplot
	gnuplot-mode god-mode gptel iedit magit multiple-cursors
	opencode org-ai org-modern org-present org-ref pdf-tools
	pinentry sudo-edit vertico visual-fill-column vterm which-key
	yasnippet zygospore))
 '(package-vc-selected-packages
   '((opencode :url "https://codeberg.org/sczi/opencode.el.git")
     (aider :url "https://github.com/tninja/aider.el"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-current-line ((t (:foreground "tan" :inherit line-number))))
 '(tab-bar ((t (:inherit variable-pitch :background "grey17" :foreground "red"))))
 '(tab-line ((t (:inherit variable-pitch :background "grey17" :foreground "pink2" :height 0.9)))))
 ;not terminal friendly;'(region ((t (:background "#444155")))))

;; enabled functions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
