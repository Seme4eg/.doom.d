;;; ewal-doom-one-light-theme.el --- Let colors be extra vivid -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;;; Commentary:
;;; An `ewal' light theme, based on `doom-one' from
;;; https://github.com/doomemacs/themes
;;; Do diff to see what's changed.
;;; SPC h F - list all faces.
;;; ~/.config/emacs/.local/straight/repos/themes/themes/doom-one-light-theme.el
;;; see the 'ref.css' to get a hang on which vars correspond to which color in
;;; doom-one-theme.

;;; Code:

(require 'ewal)
(require 'doom-themes)

(ewal-load-colors)
;; most likely its improper to set cursors in the theme itself and is better to
;; be done via hooks, but this way is just more convenient for me.
(ewal-evil-cursors-set-colors)

(def-doom-theme
 ewal-doom-one-light
 "A dynamic pywal light theme, based on `doom-one'."

 ;; name        default   256       16
 ((bg         `(,(ewal-get-color 'background  0) "black"   "black"))
  (fg         `(,(ewal-get-color 'foreground  0) "#bfbfbf" "brightwhite"))

  ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
  ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
  ;; or region), especially when paired with the `doom-darken', `doom-lighten',
  ;; and `doom-blend' helper functions.
  (bg-alt     `(,(ewal-get-color 'background 0.1) "black" "black"))
  (fg-alt     `(,(ewal-get-color 'foreground 0.8) "#2d2d2d" "white"))

  ;; These should represent a spectrum from bg to fg, where base0 is a starker
  ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
  ;; dark grey, base0 should be white and base8 should be black.
  (base0      `(,(ewal-get-color 'background +0.7) "#e7e7e7" "brightblack"))
  (base1      `(,(ewal-get-color 'background +0.2) "#1e1e1e" "brightblack"))
  (base2      `(,(ewal-get-color 'background -0.1)  "#dfdfdf" "brightblack"))
  (base3      `(,(ewal-get-color 'background -0.2) "#c6c7c7" "brightblack"))
  (base4      `(,(ewal-get-color 'comment    -0.2)   "#9ca0a4" "brightblack"))
  (base5      `(,(ewal-get-color 'background -0.7)  "#424242" "brightblack"))
  (base6      `(,(ewal-get-color 'background -0.77) "#2e2e2e" "brightblack"))
  (base7      `(,(ewal-get-color 'background -0.84) "#1e1e1e" "brightblack"))
  (base8      `(,(ewal-get-color 'background -0.91) "black"   "black"))

  (grey       base4)
  (red        `(,(ewal-get-color 'red       0)   "#e45649" "red"))
  (orange     `(,(ewal-get-color 'red       -0.2) "#dd8844" "brightred"))
  (green      `(,(ewal-get-color 'green     -0.1) "#50a14f" "green"))
  (teal       `(,(ewal-get-color 'green     -0.3) "#44b9b1" "brightgreen"))
  (yellow     `(,(ewal-get-color 'yellow    0)   "#986801" "yellow"))
  (blue       `(,(ewal-get-color 'blue      0)   "#4078f2" "brightblue"))
  (dark-blue  `(,(ewal-get-color 'blue      -0.2) "#a0bcf8" "blue"))
  (magenta    `(,(ewal-get-color 'magenta   -0.2)   "#a626a4" "magenta"))
  (violet     `(,(ewal-get-color 'magenta   -0.4) "#b751b6" "brightmagenta"))
  (cyan       `(,(ewal-get-color 'cyan      0)   "#0184bc" "brightcyan"))
  (dark-cyan  `(,(ewal-get-color 'cyan      -0.2) "#005478" "cyan"))


  ;; These are the "universal syntax classes" that doom-themes establishes.
  ;; These *must* be included in every doom themes, or your theme will throw an
  ;; error, as they are used in the base theme defined in doom-themes-base.
  (highlight      blue)
  (vertical-bar   (doom-darken base2 0.1))
  (selection      dark-blue)
  (builtin        magenta)
  (comments       base4)
  (doc-comments   (doom-darken comments 0.15))
  (constants      violet)
  (functions      magenta)
  (keywords       red)
  (methods        cyan)
  (operators      blue)
  (type           yellow)
  (strings        green)
  (variables      (doom-darken magenta 0.36))
  (numbers        orange)
  (region         `(,(doom-darken (car bg-alt) 0.1) ,@(doom-darken (cdr base0) 0.3)))
  (error          red)
  (warning        yellow)
  (success        green)
  (vc-modified    orange)
  (vc-added       green)
  (vc-deleted     red)

  ;; These are extra color variables used only in this theme; i.e. they aren't
  ;; mandatory for derived themes.
  (modeline-fg              fg)
  (modeline-fg-alt          (doom-blend violet base4 0.2))
  (modeline-bg              base1)
  (modeline-bg-alt          base2)
  (modeline-bg-inactive     (doom-darken bg 0.1))
  (modeline-bg-alt-inactive `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))

  ;;;; Base theme face overrides
 (((font-lock-comment-face &override) :background 'unspecified)
  ((font-lock-doc-face &override) :slant 'italic)
  ((line-number &override) :foreground (doom-lighten base4 0.15))
  ((line-number-current-line &override) :foreground base8)
  (mode-line :background modeline-bg :foreground modeline-fg)
  (mode-line-inactive :background modeline-bg-inactive :foreground modeline-fg-alt)
  (mode-line-emphasis :foreground highlight)
  (shadow :foreground base4)
  (tooltip :background base1 :foreground fg)

   ;;;; centaur-tabs
  (centaur-tabs-unselected :background bg-alt :foreground base4)
   ;;;; css-mode <built-in> / scss-mode
  (css-proprietary-property :foreground orange)
  (css-property             :foreground green)
  (css-selector             :foreground blue)
   ;;;; doom-modeline
  (doom-modeline-bar :background highlight)
   ;;;; ediff <built-in>
  (ediff-current-diff-A        :foreground red   :background (doom-lighten red 0.8))
  (ediff-current-diff-B        :foreground green :background (doom-lighten green 0.8))
  (ediff-current-diff-C        :foreground blue  :background (doom-lighten blue 0.8))
  (ediff-current-diff-Ancestor :foreground teal  :background (doom-lighten teal 0.8))
   ;;;; helm
  (helm-candidate-number :background blue :foreground bg)
   ;;;; lsp-mode
  (lsp-ui-doc-background      :background base0)
   ;;;; magit
  (magit-blame-heading     :foreground orange :background bg-alt)
  (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
  (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)
   ;;;; markdown-mode
  (markdown-markup-face     :foreground base5)
  (markdown-header-face     :inherit 'bold :foreground red)
  ((markdown-code-face &override)       :background base1)
  (mmm-default-submode-face :background base1)
   ;;;; outline <built-in>
  ((outline-1 &override) :foreground red)
  ((outline-2 &override) :foreground orange)
   ;;;; org <built-in>
  ((org-block &override) :background base1)
  ((org-block-begin-line &override) :foreground fg :slant 'italic)
  (org-ellipsis :underline nil :background bg     :foreground red)
  ((org-quote &override) :background base1)
   ;;;; posframe
  (ivy-posframe               :background base0)
   ;;;; selectrum
  (selectrum-current-candidate :background base2)
   ;;;; vertico
  (vertico-current :background base2)
   ;;;; solaire-mode
  (solaire-mode-line-face :inherit 'mode-line :background modeline-bg-alt)
  (solaire-mode-line-inactive-face
   :inherit 'mode-line-inactive
   :background modeline-bg-alt-inactive)
   ;;;; web-mode
  (web-mode-current-element-highlight-face :background dark-blue :foreground bg)
   ;;;; wgrep <built-in>
  (wgrep-face :background base1)
  (corfu-current :background base3)
   ;;;; whitespace
  ((whitespace-tab &override)         :background (if (not (default-value 'indent-tabs-mode)) base0 'unspecified))
  ((whitespace-indentation &override) :background (if (default-value 'indent-tabs-mode) base0 'unspecified)))

  ;;;; Base theme variable overrides-
 ())

(provide-theme 'ewal-doom-one-light)

;;; ewal-doom-one-light-theme.el ends here
