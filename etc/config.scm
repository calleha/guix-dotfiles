;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (nongnu packages linux)
	     (nongnu system linux-initrd))
(use-service-modules authentication cups desktop networking sound ssh xorg)
(use-package-modules admin emacs emacs-xyz gnome imagemagick networking rsync ssh video xdisorg xorg linux commencement)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (cons* iwlwifi-firmware
		   %base-firmware))
  (locale "en_US.utf8")
  (timezone "Europe/Stockholm")
  (keyboard-layout (keyboard-layout "us"
				    #:options '("ctrl:swap_lalt_lctl_lwin" "ctrl:swap_ralt_rctl" "caps:hyper")))
  (host-name "thinkpad-yoga")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "calleha")
                  (comment "calleha")
                  (group "users")
                  (home-directory "/home/calleha")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "input")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (cons* emacs emacs-exwm emacs-guix
		   emacs-org-ref emacs-org-modern emacs-org-present emacs-visual-fill-column
		   emacs-gptel emacs-multiple-cursors emacs-which-key emacs-vertico emacs-corfu
		   emacs-pdf-tools emacs-vterm emacs-sudo-edit emacs-avy emacs-god-mode
		   emacs-magit emacs-iedit emacs-gnuplot emacs-dmenu emacs-pinentry emacs-caps-lock
		   emacs-emms emacs-transmission emacs-paredit emacs-bluetooth
		   ;; not available/working
		   ;emacs-exwm-modeline emacs-aider emacs-addressbook-bookmark emacs-zygospore
		   iwd
		   xorg-server xset xrandr xmodmap setxkbmap xhost xsetroot xbacklight xdotool
		   unclutter
		   imagemagick
		   htop
		   mpv
		   rsync
		   libva
		   light
		   gcc-toolchain
                   %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service dhcpcd-service-type)
                 (service cups-service-type)
		 (service iwd-service-type)
		 (service openssh-service-type)
		 (service xorg-server-service-type)
		 (set-xorg-configuration
		  (xorg-configuration
		   (keyboard-layout keyboard-layout)))
		 (service gnome-desktop-service-type)
		 (service bluetooth-service-type)
		 (service upower-service-type
			  (upower-configuration
			   (percentage-action 5)
			   (critical-power-action 'hibernate)))
		 )

           ;; This is the default list of services we
           ;; are appending to.
	   (modify-services %desktop-services
			    (guix-service-type config => (guix-configuration
			      (inherit config)
			      (substitute-urls
			       (append (list ;"https://substitutes.nonguix.org"
					     "https://nonguix-proxy.ditigal.xyz")
				       %default-substitute-urls))
			      (authorized-keys
			       (append (list (local-file "./signing-key.pub"))
				       %default-authorized-guix-keys))))
			    (delete network-manager-service-type)
			    (delete wpa-supplicant-service-type)
			    (delete upower-service-type))))
  
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/nvme0n1"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "4c523247-9743-49f1-bbf9-afc28a000f14"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "774c7e04-e2c3-432f-9cb6-b14843c350f1"
                                  'ext4))
                         (type "ext4")) %base-file-systems))

  (swap-devices
   (list
    (swap-space
     (target "/var/swapfile")
     (dependencies file-systems))))

  (kernel-arguments
   (cons* "resume=/dev/nvme0n1p1"
	  "resume_offset=3143680"
	  %default-kernel-arguments)))
