;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "sad"
      user-mail-address "somespammail@bk.ru")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; (setq doom-font (font-spec :family "Source Code Pro" :size 16 :weight 'light))

;; colors for treemacs icons
(after! treemacs
  (setq doom-themes-treemacs-theme "doom-colors"
        treemacs-follow-mode t
        treemacs-space-between-root-nodes      nil ;; t
        treemacs-width                         32  ;; 35
        ))
;; If you still want the default icons, this works for me
;; (after! (doom-themes treemacs)
;;   (setq doom-themes-treemacs-theme "Default"))

(after! spell-fu
  (setq spell-fu-idle-delay 0.5))  ; default is 0.25

(setq better-jumper-context 'buffer) ;; for now

(map! :leader "gv" 'git-gutter:popup-hunk)

;; environment --> major

(global-subword-mode 1)
(setq-default fill-column 80) ;; 70, must be a default value to work
(setq-default display-fill-column-indicator 80) ;; default?
(setq tab-width 2)
      ;; use-dialog-box nil)

;; environment -> hooks
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook
          (lambda ()
            (auto-fill-mode)))

;; kbds
(map! :leader "x" 'execute-extended-command)

;; does this even work? and is it even needed?
(set-docsets! 'js2-mode "JavaScript")

;; Enable Gravatars
;; This will enable gravatars when viewing commits.
;; The service used by default is Libravatar.
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(setq
 doom-theme 'doom-opera
 org-ellipsis " ▾ "
 ;; org-bullets-bullet-list '("·")
 org-tags-column -80
 )

;; pkgs
(setq projectile-project-search-path '("~/git/"))

;; org
(setq org-log-done t ;; enable logging when tasks are complete
      ;; open code edit buffers in the same window
      ;; org-src-window-setup 'current-window
      org-use-speed-commands t
      org-return-follows-link t
      org-hide-emphasis-markers t)

;; org-mode agenda options
(setq org-deadline-warning-days 7) ;; warn of any deadlines in next 7 days
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;;don't show tasks that are scheduled or have deadlines in the normal todo list
;; (setq org-agenda-todo-ignore-deadlines (quote all))
;; (setq org-agenda-todo-ignore-scheduled (quote all))

;; TODO: how to do it with evil embrace?
;; now after typing '<el TAB' u will get code block with 'emacs-lisp' src
(after! org (add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC")))

(setq input-method-history (list "russian-computer")) ;; FIXME still doesn't switch
(setq lsp-vetur-format-default-formatter-html '"prettier")

;; my attempts to make forge work with custom gitlab url...
;; did not suffice elisp knowledge to do that (not all forge functions were working..)
(after! forge
  (push '("gitlab.medpoint24.ru" "gitlab.medpoint24.ru/api/v4"
          "gitlab.medpoint24.ru" forge-gitlab-repository) forge-alist))

;; ==================== DEV ====================

;; === sh ===
(add-hook 'sh-mode-hook
          (lambda ()
            (interactive)
            (setq sh-basic-offset 2)))
(after! sh-script
  (set-company-backend! 'sh-mode
    '(company-shell :with company-yasnippet)))

;; elm
;; (setq elm-indent-offset 2)
;; (add-to-list 'company-backends 'elm-company)
(add-hook 'elm-mode-hook 'elm-format-on-save-mode)

;; js2
;; (setq js-indent-level 2)
(after! js2-mode
  (add-hook 'js2-mode-hook #'jest-minor-mode)
  (set-company-backend! 'js2-mode 'company-tide 'company-yasnippet))


;; TODO: do i even need this thing with new js settings?
;; js-prettier
;; (add-hook 'js2-mode-hook 'prettier-js-mode)
;; (setq prettier-js-args '(
;;                          "--trailing-comma" "all"
;;                          "--single-quote" "true"
;;                          "--arrow-parens" "avoid"
;;                          "--jsx-bracket-same-line" "true"
;;                          "--html-whitespace-sensitivity" "ignore"
;;                          ))
