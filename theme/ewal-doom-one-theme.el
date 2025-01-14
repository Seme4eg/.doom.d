;;; ewal-doom-one-theme.el --- Dread the color of darkness -*- lexical-binding: t; -*-

;;; Commentary:
;;; An `ewal' theme, based on `doom-one' from https://github.com/doomemacs/themes
;;; Do diff to see what's changed.
;;; SPC h F - list all faces.
;;; ~/.config/emacs/.local/straight/repos/themes/themes/doom-one-theme.el
;;; see the 'ref.css' to get a hang on which vars correspond to which color in
;;; doom-one-theme.

;;; Code:

(require 'ewal)
(require 'doom-themes)

(ewal-load-colors)

(def-doom-theme
 ewal-doom-one
 "A dark theme inspired by Atom One Dark, cutomized with `ewal'."

 ;; name        default   256       16
 ((bg         `(,(ewal-get-color 'background  0) "black"   "black"))
  (fg         `(,(ewal-get-color 'foreground  0) "#bfbfbf" "brightwhite"))

  ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
  ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
  ;; or region), especially when paired with the `doom-darken', `doom-lighten',
  ;; and `doom-blend' helper functions.
  (bg-alt     `(,(ewal-get-color 'background -0.6) "black" "black"))
  (fg-alt     `(,(ewal-get-color 'foreground -0.2) "#2d2d2d" "white"))

  ;; These should represent a spectrum from bg to fg, where base0 is a starker
  ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
  ;; dark grey, base0 should be white and base8 should be black.
  (base0      `(,(ewal-get-color 'background -1)   "black"   "black"))
  (base1      `(,(ewal-get-color 'background -0.8) "#1e1e1e" "brightblack"))
  (base2      `(,(ewal-get-color 'background -0.4) "#2e2e2e" "brightblack"))
  (base3      `(,(ewal-get-color 'background -0.2) "#262626" "brightblack"))
  (base4      `(,(ewal-get-color 'background +0.2) "#3f3f3f" "brightblack"))
  (base5      `(,(ewal-get-color 'comment     0)   "#525252" "brightblack"))
  (base6      `(,(ewal-get-color 'background +0.8) "#6b6b6b" "brightblack"))
  (base7      `(,(ewal-get-color 'background +1)   "#979797" "brightblack"))
  (base8      `(,(ewal-get-color 'foreground +0.2) "#dfdfdf" "white"))

  (grey       base4)
  (red        `(,(ewal-get-color 'red      -0.2) "#ff6655" "red"))
  (orange     `(,(ewal-get-color 'red       0)   "#dd8844" "brightred"))
  (green      `(,(ewal-get-color 'green     0.1) "#99bb66" "green"))
  (teal       `(,(ewal-get-color 'green     0.3)   "#44b9b1" "brightgreen"))
  (yellow     `(,(ewal-get-color 'yellow   -0.2) "#ECBE7B" "yellow"))
  (blue       `(,(ewal-get-color 'blue      0)   "#51afef" "brightblue"))
  (dark-blue  `(,(ewal-get-color 'blue     -0.2) "#2257A0" "blue"))
  (magenta    `(,(ewal-get-color 'magenta   0)   "#c678dd" "brightmagenta"))
  (violet     `(,(ewal-get-color 'magenta  -0.2) "#a9a1e1" "magenta"))
  (cyan       `(,(ewal-get-color 'cyan      0)   "#46D9FF" "brightcyan"))
  (dark-cyan  `(,(ewal-get-color 'cyan     -0.2) "#5699AF" "cyan"))

  ;; These are the "universal syntax classes" that doom-themes establishes.
  ;; These *must* be included in every doom themes, or your theme will throw an
  ;; error, as they are used in the base theme defined in doom-themes-base.
  (highlight      blue)
  (vertical-bar   (doom-darken base1 0.1))
  (selection      dark-blue)
  (builtin        magenta)
  (comments       base5)
  (doc-comments   (doom-lighten base5 0.25))
  (constants      violet)
  (functions      magenta)
  (keywords       blue)
  (methods        cyan)
  (operators      blue)
  (type           yellow)
  (strings        green)
  (variables      (doom-lighten magenta 0.4))
  (numbers        orange)
  (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
  (error          red)
  (warning        yellow)
  (success        green)
  (vc-modified    orange)
  (vc-added       green)
  (vc-deleted     red)

  ;; These are extra color variables used only in this theme; i.e. they aren't
  ;; mandatory for derived themes.
  (modeline-fg     fg)
  (modeline-fg-alt base5)
  (modeline-bg (doom-darken bg-alt 0.1))
  (modeline-bg-alt `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg)))
  (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
  (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg))))


 ;;;; Base theme face overrides
 (((line-number &override) :foreground base4)
  ((line-number-current-line &override) :foreground fg)
  ((font-lock-comment-face &override) :foreground comments) ;; in doom-one its 'unspecified'
  (font-lock-doc-face :inherit 'font-lock-comment-face :foreground doc-comments)
  (mode-line
   :background modeline-bg :foreground modeline-fg)
  (mode-line-inactive
   :background modeline-bg-inactive :foreground modeline-fg-alt)
  (mode-line-emphasis :foreground highlight)

  ;;;; css-mode <built-in> / scss-mode
  (css-proprietary-property :foreground orange)
  (css-property             :foreground green)
  (css-selector             :foreground blue)
  ;;;; doom-modeline
  (doom-modeline-bar :background (if doom-one-brighter-modeline modeline-bg highlight))
  (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
  (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
  (doom-modeline-buffer-project-root :foreground green :weight 'bold)
  ;;;; markdown-mode
  (markdown-markup-face :foreground base5)
  (markdown-header-face :inherit 'bold :foreground red)
  ((markdown-code-face &override) :background (doom-lighten base3 0.05))
  ;;;; solaire-mode
  (solaire-mode-line-face
   :inherit 'mode-line
   :background modeline-bg-alt)
  (solaire-mode-line-inactive-face
   :inherit 'mode-line-inactive
   :background modeline-bg-inactive-alt)

  ;;;; other stuff
  (evil-goggles-default-face
   :inherit 'region
   :background (doom-blend region bg 0.5))
  (corfu-current :background base4))

 ;;;; Base theme variable overrides-
 ())

(provide-theme 'ewal-doom-one)

;;; ewal-doom-one-theme.el ends here
