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

;; treemacs
(setq treemacs-silent-filewatch              t ;; nil
      ;; treemacs-project-follow-cleanup        t ;; nil
      treemacs-silent-refresh                t ;; nil
      ;; treemacs-sorting                       'alphabetic-desc
      treemacs-space-between-root-nodes      nil ;; t
      treemacs-width                         32) ;; 35

;; org
(setq org-log-done t ;; enable logging when tasks are complete
      ;; open code edit buffers in the same window
      ;; org-src-window-setup 'current-window
      org-use-speed-commands t
      org-return-follows-link t
      org-hide-emphasis-markers t)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; org-mode agenda options
(setq org-deadline-warning-days 7) ;; warn of any deadlines in next 7 days
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;;don't show tasks that are scheduled or have deadlines in the normal todo list
;; (setq org-agenda-todo-ignore-deadlines (quote all))
;; (setq org-agenda-todo-ignore-scheduled (quote all))

(add-hook 'org-mode-hook
          (lambda ()
            (abbrev-mode)
            (flyspell-mode)
            (auto-fill-mode)))
;; now after typing '<el TAB' u will get code block with 'emacs-lisp' src
(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))


;; ==================== DEV ====================

;; web-mode
(setq web-mode-markup-indent-offset 2
      ;; web-mode-script-padding 2 ; now is 1
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-attr-indent-offset t
      web-mode-sql-indent-offset 2
      web-mode-enable-current-column-highlight t
      web-mode-enable-current-element-highlight t)

;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            (yas-activate-extra-mode 'js2-mode)
            (prettier-js-mode)))

(add-hook 'vue-mode-hook
          (lambda ()
            (yas-activate-extra-mode 'js2-mode)
            (prettier-js-mode)))

;; js2
(setq js2-basic-offset 2)

;; (setq-default js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))
;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; js2refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "<spc> r")
;; (define-key key-translation-map (kbd ",r") (kbd "C-c b"))

;; js-prettier
(add-hook 'js2-mode-hook 'prettier-js-mode)
;; (setq prettier-js-args '(
;;                          "--trailing-comma" "all"
;;                          "--single-quote" "true"
;;                          "--arrow-parens" "avoid"
;;                          "--space-before-function-paren" "true"
;;                          ))

;; smartparens
;; ~C-M-Space {key}~ - wrap region (or just try pressing {key} when region is active)
(map! :leader
      "mu" 'sp-unwrap-sexp
      "mk" 'sp-kill-sexp
      "mr" 'sp-rewrap-sexp ;; also 'swap-enclosing-sexp might be useful
      "mn" 'sp-forward-sexp
      "mp" 'sp-backward-sexp
      "ms" 'sp-slurp-hybrid-sexp ;; take next expression in cur parens
      )

;; other pkgs
(setq emmet-indentation 2
      emmet-move-cursor-between-quotes t)

(map! :leader "j" 'avy-goto-char)

;; (use-package dmenu
;;   :init (evil-leader/set-key "d" 'dmenu))

(map! :leader "y" 'popup-kill-ring)

(defun evil-window-split()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun evil-window-vsplit()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(defun sad/insert-line-before (times)
  ;; insert a line 'above' cur. cursor position
  (interactive "p")
  (save-excursion
    (move-beginning-of-line 1)
    (newline times)))

(global-set-key (kbd "C-S-o") 'sad/insert-line-before) ;; `C-6 {binded kbd}`
