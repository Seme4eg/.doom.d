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

(setq doom-font (font-spec :family "Source Code Pro" :size 16))

;; colors for treemacs icons
(after! treemacs
  (treemacs-follow-mode)
  (setq doom-themes-treemacs-theme "doom-colors"
        treemacs-space-between-root-nodes      nil ;; t
        treemacs-width                         32  ;; 35
        ))
;; If you still want the default icons, this works for me
;; (after! (doom-themes treemacs)
;;   (setq doom-themes-treemacs-theme "Default"))

(setq better-jumper-context 'buffer) ;; for now

(map! :leader "gv" 'git-gutter:popup-hunk)

;; environment --> major
(global-subword-mode)
(global-display-fill-column-indicator-mode)
(global-auto-revert-mode)

(setq-default
 fill-column 80 ;; 70, must be a default value to work
 display-fill-column-indicator-column 80
 )

;; environment -> hooks
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'auto-fill-mode)

;; kbds
(map! :leader "x" 'execute-extended-command)

;; does this even work? and is it even needed?
(set-docsets! 'js2-mode "JavaScript")

;; Enable Gravatars REVIEW does it even works?
;; This will enable gravatars when viewing commits.
;; The service used by default is Libravatar.
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(setq
 doom-theme 'doom-opera
 )

;; pkgs
(setq projectile-project-search-path '("~/git/"))

;; org

;; (add-hook! 'org-mode-hook (company-mode -1))
;; (add-hook! 'org-capture-mode-hook (company-mode -1))

(setq
  ;; org-src-window-setup 'current-window
  org-ellipsis " ▾ "
  org-tags-column -80
  org-hide-emphasis-markers t
  ;; org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
  ;; +org-capture-todo-file "tasks.org"
  )

;; journal setup
(setq
  org-journal-date-prefix "#+TITLE: "
  org-journal-time-prefix "* "
  org-journal-date-format "%a, %Y-%a-%d"
  org-journal-file-format "%Y-%m-%d.org")

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold))

;; org-mode agenda options
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
(after! sh-script
  (set-company-backend! 'sh-mode
    '(company-shell :with company-yasnippet)))

;; elm
;; (add-to-list 'company-backends 'elm-company)
;; (add-hook 'elm-mode-hook 'elm-format-on-save-mode)

(after! js2-mode
  (add-hook 'js2-mode-hook #'jest-minor-mode)
  (set-company-backend! 'js2-mode 'company-tide 'company-yasnippet))
