;; (require 'exwm)
(require 'exwm-systemtray)
;; (setq exwm-systemtray-height 32)
(exwm-systemtray-enable)
;; (require 'exwm-randr)
;; (exwm-randr-enable)

;; using xim input
(require 'exwm-xim)
(exwm-xim-enable)
(push ?\C-\\ exwm-input-prefix-keys)   ;; use Ctrl + \ to switch input method

;; Annoying focus issues
(setq mouse-autoselect-window nil
        focus-follows-mouse t
        exwm-workspace-warp-cursor t
        exwm-workspace-number 5)
        ;exwm-workspace-display-echo-area-timeout 5
        ;exwm-workspace-minibuffer-position 'bottom)

;; update buffer names of opened windows whenever 2 windows with same
;; name appear (like Opera & Opera<1> - u gonna see that)
(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))
;; (add-hook 'exwm-update-title-hook
;;           (lambda ()
;;             (pcase exwm-class-name
;;               ("qutebrowser" (exwm-workspace-rename-buffer (format "Qutebrowser: %s" exwm-title))))))

(exwm-enable)

(defun exwm/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun exwm/bind-function (key invocation &rest bindings)
  "Bind KEYs to FUNCTIONs globally"
  (while key
    (exwm-input-set-key (kbd key)
                        `(lambda ()
                           (interactive)
                           (funcall ',invocation)))
    (setq key (pop bindings)
          invocation (pop bindings))))

(defun exwm/bind-command (key command &rest bindings)
  "Bind KEYs to COMMANDs globally"
  (while key
    (exwm-input-set-key (kbd key)
                        `(lambda ()
                           (interactive)
                           (exwm/run-in-background ,command)))
    (setq key (pop bindings)
          command (pop bindings))))

(defun efs/exwm-init-hook ()
  (exwm-workspace-switch-create 1)
  ;; Launch apps that will run in the background:
  ;; (exwm/run-in-background "dunst")
  (exwm/run-in-background "nm-applet") ;; - network-manager system tray icons
  ;; (exwm/run-in-background "syncthing-gtk --minimized")
  ;; (exwm/run-in-background "udiskie -t")
  ;; (exwm/run-in-background "redshift -l 47.675510:-122.203362 -t 6500:3500")

  ;; (defun dw/setup-window-by-class ()
  ;;   (interactive)
  ;;   (pcase exwm-class-name
  ;;     ("Emacs" (call-interactively #'exwm-input-toggle-keyboard))
  ;;     ("Xephyr" (call-interactively #'exwm-input-toggle-keyboard))
  ;;     ("discord" (exwm-workspace-move-window 3))
  ;;     ("Spotify" (exwm-workspace-move-window 4))
  ;;     ("qutebrowser" (exwm-workspace-move-window 2))
  ;;     ("qjackctl" (exwm-floating-toggle-floating))
  ;;     ("mpv" (exwm-floating-toggle-floating)
  ;;      (dw/exwm-floating-toggle-pinned))
  ;;     ("gsi" (exwm-input-toggle-keyboard)))
  )

;; (add-hook 'exwm-mode-hook
;;             (lambda ()
;;               (evil-local-set-key 'motion (kbd "C-u") nil)))

;; Do some post-init setup
  (add-hook 'exwm-init-hook #'efs/exwm-init-hook)

;; Manipulate windows as they're created
;; (add-hook 'exwm-manage-finish-hook
;;           (lambda ()
;;             ;; Send the window where it belongs
;;             (dw/setup-window-by-class)))

;; Hide the modeline on all X windows
                                        ;(exwm-layout-hide-mode-line)))

;; Hide the modeline on all floating windows
(add-hook 'exwm-floating-setup-hook
          (lambda ()
            (exwm-layout-hide-mode-line)))

;; rebind caps lock to ctrl and caps to right control
(defun dw/run-xmodmap ()
  (interactive)
  ;; TODO: what is 'i3'? hear lots bout it, but still dunno
  ;; (start-process-shell-command "xmodmap" nil "xmodmap ~/.dotfiles/.config/i3/Xmodmap"))
  (start-process-shell-command "xmodmap" nil "xmodmap ~/.doom.d/exwm/Xmodmap"))

(defun dw/update-wallpapers ()
   ;; for command below to work install it first
   ;; also u might need to change the path to the bg as well
  (interactive)
  (start-process-shell-command
   "feh" nil "feh --bg-scale ~/Pictures/xXfymMYfBFM.jpg"))
   ;; "feh" nil
   ;; (format "feh --bg-scale ~/Pictures/%s" (alist-get 'desktop/background dw/system-settings))))

;; (setq dw/panel-process nil)
;; (defun dw/kill-panel ()
;;   (interactive)
;;   (when dw/panel-process
;;     (ignore-errors
;;       (kill-process dw/panel-process)))
;;   (setq dw/panel-process nil))

;; (defun dw/start-panel ()
;;   (interactive)
;;   (dw/kill-panel)
;;   (setq dw/panel-process (start-process-shell-command "polybar" nil "polybar panel")))

;; (defun dw/update-screen-layout ()
;;   (interactive)
;;   (let ((layout-script "~/.bin/update-screens"))
;;      (message "Running screen layout script: %s" layout-script)
;;      (start-process-shell-command "xrandr" nil layout-script)))

(defun dw/configure-desktop ()
  (interactive)
    (dw/run-xmodmap)
    ;; (dw/update-screen-layout)
    (run-at-time "2 sec" nil (lambda () (dw/update-wallpapers))))

(defun dw/on-exwm-init ()
  (dw/configure-desktop)
  ;; (dw/start-panel)
  )

;; (when dw/exwm-enabled
  ;; Configure the desktop for first load
  (add-hook 'exwm-init-hook #'dw/on-exwm-init)
;; )

;; These keys should always pass through to Emacs (in line-mode)
(setq exwm-input-prefix-keys
      '(?\C-x
        ?\C-h
        ?\SPC
        ;; ?\C-u
        ?\M-x
        ?\M-`
        ?\M-&
        ?\M-:
        ?\C-\M-j ;; buffer list
        ;; ?\C-\M-k  ;; Browser list
        ;; ?\C-\M-n  ;; Next workspace
        ;; ?\C-\M-'  ;; Popper toggle
        ?\C-\ ;; ctrl + space
        ;; ?\C-\;
        ))

;; Ctrl+Q will enable the next key to be sent directly to the window
(define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; (defun exwm/run-qute ()
;;   (exwm/run-in-background "qutebrowser")
;;   (exwm-workspace-switch-create 2))

;; (exwm/bind-function
;;  "s-o" 'exwm/run-qute
;;  "s-q" 'kill-buffer)

(exwm/bind-command
 "s-p" "playerctl play-pause"
 "s-[" "playerctl previous"
 "s-]" "playerctl next")

(desktop-environment-mode)
(setq desktop-environment-brightness-small-increment "2%+"
      desktop-environment-brightness-small-decrement "2%-"
      desktop-environment-brightness-normal-increment "5%+"
      desktop-environment-brightness-normal-decrement "5%-"
      ;; desktop-environment-screenshot-command "flameshot gui")
      )

;; set up global key bindings. These always work, no matter the input state.
;; keep in mind that changing this list after EXWM initializes has no effect.
(setq exwm-input-global-keys
      `(
        ;; reset to line-mode (C-c C-k switches to char-mode via
        ;; exwm-input-release-keyboard
        ([?\s-\C-r] . exwm-reset)
        ;; ([?\s-r] . exwm-reset)

        ;; Move between windows
        ;; ([?\s-h] . windmove-left)
        ;; ([?\s-l] . windmove-right)
        ;; ([?\s-k] . windmove-up)
        ;; ([?\s-j] . windmove-down)

        ([?\s-w] . exwm-workspace-switch)

        ;; Bind "s-<f2>" to "slock", a simple X display locker.
        ([s-f2] . (lambda ()
                    (interactive)
                    (start-process "" nil "/usr/bin/slock")))

        ;; Launch applications via chell command
        ([?\s-o] . (lambda (command)
                     (interactive (list (read-shell-command "$ ")))
                     (start-process-shell-command command nil command)))

        ([?\s-i] . exwm-input-toggle-keyboard)
        ([?\s-e] . dired-jump)
        ([?\s-E] . (lambda () (interactive) (dired "~")))
        ([?\s-Q] . (lambda () (interactive) (kill-buffer)))
        ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))

(exwm-input-set-key (kbd "<s-return>") 'vterm)
;; TODO: write my own .desktop files finder that will be compatible with
;; vertico
;; You might therefore be interested in this link:
;; https://www.mattduck.com/emacs-fuzzy-launcher.html
;; (exwm-input-set-key (kbd "s-SPC") 'app-launcher-run-app)
(exwm-input-set-key (kbd "s-f") 'exwm-layout-toggle-fullscreen)
