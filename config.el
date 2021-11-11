;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq
  ;; Some functionality uses this to identify you,
  ;; e.g. GPG configuration, email clients, file templates and snippets.
  user-full-name "sad"
  user-mail-address "418@duck.com"

  doom-theme 'doom-opera
  org-directory "~/org/"
  ;; Line numbers are pretty slow all around. The performance boost of
  ;; disabling them outweighs the utility of always keeping them on.
  ;;    (c) hlissner
  display-line-numbers-type nil
  doom-font (font-spec :family "Source Code Pro" :size 16)

  ;; IMO, modern editors have trained a bad habit into us all: a burning need for
  ;; completion all the time -- as we type, as we breathe, as we pray to the
  ;; ancient ones -- but how often do you *really* need that information? I say
  ;; rarely. So opt for manual completion
  ;;    (c) hlissner
  company-idle-delay nil
  )

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Disable invasive lsp-mode features
(setq
  ;; lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
  lsp-ui-doc-enable nil        ; slow and redundant with K
  ;; lsp-enable-symbol-highlighting nil
  )

;; Modules

;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;;; :tools magit
(setq
  ;; magit-save-repository-buffers nil
  ;; Don't restore the wconf after quitting magit, it's jarring
  magit-inhibit-save-previous-winconf t
  transient-values '((magit-rebase "--autosquash" "--autostash")
                      (magit-pull "--rebase" "--autostash"))
  )

;; :ui doom-dashboard
;; (setq fancy-splash-image (concat doom-private-dir "splash.png"))
;; Hide the menu for as minimalistic a startup screen as possible.
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; :app everywhere FIXME: throws error when first loading
(after! emacs-everywhere
  ;; Easier to match with a bspwm rule:
  ;;   bspc rule -a 'Emacs:emacs-everywhere' state=floating sticky=on
  (setq emacs-everywhere-frame-name-format "emacs-anywhere")

  ;; The modeline is not useful to me in the popup window. It looks much nicer
  ;; to hide it.
  (remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

  ;; Semi-center it over the target window, rather than at the cursor position
  ;; (which could be anywhere).
  (defadvice! center-emacs-everywhere-in-origin-window (frame window-info)
    :override #'emacs-everywhere-set-frame-position
    (cl-destructuring-bind (x y width height)
        (emacs-everywhere-window-geometry window-info)
      (set-frame-position frame
                          (+ x (/ width 2) (- (/ width 2)))
                          (+ y (/ height 2))))))

;; TODO: how to redefine it without last function? so i don't see link for github
;; (setq +doom-dashboard-functions
;;       (doom-dashboard-widget-banner
;;        doom-dashboard-widget-loaded)
;;       )

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

;; TODO: wrap a func below eith defadvice so it insets '~' before and after
(map! :leader "ik" 'edmacro-insert-key)

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

;; org capture templates redefining
(setq org-time-stamp-formats '("%a <%d-%m-%Y>" . "<%a %d-%m-%Y %H:%M>"))

(setq org-capture-templates
  '(("a" "New tea" entry
      (file +org-capture-project-notes-file)
      "%[~/git/tea/template]" :jump-to-captured t :clock-in t :clock-keep t)
     ("t" "Personal todo" entry
      (file +org-capture-todo-file)
      "* [ ] %?\n%i\n%a" :prepend t)
     ("n" "Personal notes" entry
       (file +org-capture-notes-file)
       "* %u %?\n%i\n%a" :prepend t)
     ("j" "Journal" entry
       (file+olp+datetree +org-capture-journal-file)
       "* %U %?\n%i\n%a" :prepend t)
     ("p" "Templates for projects")
     ("pt" "Project-local todo" entry
       (file +org-capture-project-todo-file)
       "* TODO %?\n%i\n%a" :prepend t)
     ("pn" "Project-local notes" entry
       (file +org-capture-project-notes-file)
       "* %U %?\n%i\n%a" :prepend t)
     ("pc" "Project-local changelog" entry
       (file-headline +org-capture-project-changelog-file "Unreleased")
       "* %U %?\n%i\n%a" :prepend t)
     ("o" "Centralized templates for projects")
     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))
  )
;; journal setup
(setq
  org-journal-date-prefix "#+TITLE: "
  org-journal-time-prefix "* "
  ;; org-journal-date-format "%a, %d-%m-%Y"
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

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

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

;; UI

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
