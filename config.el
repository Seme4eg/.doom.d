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

(after! evil
  (defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
    (evil-scroll-line-to-center (line-number-at-pos))))

;; environment --> major

(setq-default indent-tab-mode nil)
(setq tab-width 2
      fill-column 110 ;; must be (?) a default value to work
      echo-keystokes 0.1
      use-dialog-box nil)

;; environment -> hooks
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'markdown-mode-hook 'auto-fill-mode)

;; modes

(delete-selection-mode t)
;; automatically save/restore sessions ; breaks with perspective
;; (desktop-save-mode 1)
(global-prettify-symbols-mode t)
(global-subword-mode 1)

;; kbds

(map! "C-;" 'comment-or-uncomment-region
      :leader
      "bo" 'switch-to-buffer
      "os" 'doom/open-scratch-buffer
      "x" 'counsel-M-x)


;; pkgs

;; (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

;; (smex-initialize)
;; (!map "M-X" 'smex-major-mode-commands)

(map! :leader
      "pG" 'counsel-projectile-git-grep
      "pO" 'counsel-projectile-org-capture
      "pS" 'ag-project)

(setq ag-highlight-search t
      ag-reuse-buffers t
      ag-reuse-window t)

;; (add-hook 'ag-mode-hook
;;           (lambda ()
;;             (wgrep-ag-setup)
;;             (define-key ag-mode-map (kbd "n") 'evil-search-next)
;;             (define-key ag-mode-map (kbd "N") 'evil-search-previous)))

(setq treemacs-silent-filewatch              t ;; nil
      ;; treemacs-project-follow-cleanup        t ;; nil
      treemacs-silent-refresh                t ;; nil
      ;; treemacs-sorting                       'alphabetic-desc
      treemacs-space-between-root-nodes      nil ;; t
      treemacs-width                         32) ;; 35
