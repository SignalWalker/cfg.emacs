;; meta
(setq user-emacs-directory (expand-file-name "emacs" (getenv "XDG_STATE_HOME")))
(message "user-emacs-directory: %s" user-emacs-directory)

(setq user-emacs-cache-directory (expand-file-name "emacs" (getenv "XDG_CACHE_HOME")))
(message "user-emacs-cache-directory: %s" user-emacs-cache-directory)

;; configure straight.el
(setq straight-use-package-by-default 't)
(setq straight-base-dir (expand-file-name "straight.el" user-emacs-directory))
(setq straight-build-dir (expand-file-name "straight.el" user-emacs-cache-directory))

(message "straight-base-dir: %s" straight-base-dir)
(message "straight-build-dir: %s" straight-build-dir)

;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/master/install.el"
         'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load-file bootstrap-file))

(straight-use-package 'use-package)

;; packages
;;;; ui
(use-package evil
  :init
  (setq evil-split-window-below 't)
  (setq evil-split-window-right 't)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-fine-undo 't)
  :config
  (evil-mode 1))

(use-package base16-theme)

;;;; tools
(use-package guix)
(use-package org-mode)
(use-package mediawiki)

;;;; language
(use-package geiser-guile)
