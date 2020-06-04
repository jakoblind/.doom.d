;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jakob Lind"
      user-mail-address "karl.jakob.lind@gmail.com")

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
(setq doom-font (font-spec :family "monospace" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-Iosvkem)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; wrap text
(global-visual-line-mode 1)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(use-package! magit :config (setq magit-completing-read-function
                                  'magit-ido-completing-read))

 (after! magit (progn
                         (remove-hook 'server-switch-hook 'magit-commit-diff) ;dont show diff on commit
                         (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
                         (defun git-commit-check-style-conventions (force) t) ;dont ask if commit message is too long. i already know) )
                        ;; Make magit never ask for a stash message. Instead always use default.
                         (defun magit-stash-read-message ()
                           (concat (format "On %s: " (or (magit-get-current-branch) "(no branch)")) (magit-rev-format "%h %s")))))

(use-package! lsp-mode
  ;:hook
  ;(typescript-mode . lsp)
  ;(dart-mode . lsp)
  :config (setq company-minimum-prefix-length 1
                                     company-idle-delay 0.0))

(use-package! org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (http . t))))

;(setq gc-cons-threshold 16777216)


;(use-package! lsp-dart :config (dap-register-debug-template "Flutter :: AT debug"
;                               (list :program "lib/entrypoints/main_at.dart"
;                                     :type "flutter"
;                                     :args '("--flavor" "at"))))

(after! ido (define-key ido-common-completion-map "\C-n" 'ido-next-match)
(define-key ido-common-completion-map "\C-p" 'ido-prev-match))

; MAC KEY BINDINGS
; META: cmd key
; CTRL: ctrl key
; SUPER: option key
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(setq mac-option-modifier 'super)

(global-subword-mode 1)


;; keybindings

(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

(global-set-key (kbd "C-x p") 'projectile-find-file)
(global-set-key (kbd "C-x i") 'doom/find-file-in-other-project)

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(define-key! 'override "M-x" #'amx)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "M-'") 'er/contract-region)


;;multi cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "s->") 'mc/mark-next-like-this-word)
(global-set-key (kbd "s-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
