;; --------------------------------------
;; Install packages
;; --------------------------------------
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(package-initialize)

;; --------------------------------------
;; Configuration
;; --------------------------------------
(setq inhibit-splash-screen t) ; Inhibit initial splash screen
(menu-bar-mode -1) ; Remove menu bar
(setq default-major-mode 'text-mode) ; Always default to text mode for new buffers
(global-linum-mode t) ; Global linenumber mode
(setq linum-format "%4d \u2502 ")

; Backups
(setq backup-directory-alist '(("." . ".emacs_saves"))) ; Store backup files into separate directory
(setq backup-by-copying t) ; Always backup by copying, not by renaming original

; Themes
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

; Indentation
(defun set-newline-and-indent ()
  (local-set-key (kdb "RET") 'newline-and-indent))
(add-hook 'c-mode 'set-new-line-and-indent) ; Auto indentation when writing C code

(setq-default tab-width 2)
(setq js-indent-level 2)
(setq c-basic-offset 4)
(setq css-indent-offset 2)
(setq sh-basic-offset 2)
(setq-default indent-tabs-mode nil)
(set-variable 'py-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)


; Default encoding
(setq-default buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)

; Default window size
(add-to-list 'default-frame-alist '(width .  110)) ; characters
(add-to-list 'default-frame-alist '(height . 60)) ; lines

; ELPY
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(setq python-shell-interpreter "python3")

; Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

