; Inhibit initial splash screen
(setq inhibit-splash-screen t)

; Always default to text mode for new buffers
(setq default-major-mode 'text-mode)

; Store backup files into separate directory
(setq backup-directory-alist '(("." . ".emacs_saves")))

; Always backup by copying, not by renaming original
(setq backup-by-copying t)

; Select color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

; Auto indentation when writing C code
(defun set-newline-and-indent ()
  (local-set-key (kdb "RET") 'newline-and-indent))
(add-hook 'c-mode 'set-new-line-and-indent)

; Change indent-level when writing C code to 3
(setq-default c-basic-offset 3)

; Default encoding of buffers
(setq-default buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)

; Default window size
(add-to-list 'default-frame-alist '(width .  110)) ; characters
(add-to-list 'default-frame-alist '(height . 60)) ; lines