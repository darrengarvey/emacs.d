;; Added by Package.el.This must come before configurations of
;; installed packages.Don 't delete this line.  If you don' t want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)
(require 'package)
(add-to-list 'load-path "~/.emacs.d/use-package")
(require 'use-package)
(add-to-list 'package-archives
     '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (dolist (package '(use-package))
;;    (unless (package-installed-p package)
;;      (package-install package)))

(setq use-package-always-ensure t)

;; color-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/twilight-theme")
(load-theme 'twilight t)


;; PACKAGES
(use-package smex
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

(use-package ido
  :config (progn
            (ido-everywhere t)
            (ido-mode t)))

(use-package ibuffer
  :defer t
  :bind ("C-x C-b" . ibuffer)
  :config (add-hook 'ibuffer-mode-hook
                    (lambda ()
                      (ibuffer-switch-to-saved-filter-groups "default"))))

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . ".*\\.el$")))
               ("build" (or
                         (name . "BUILD")
                         (name . "WORKSPACE")))
               ("proto" (name . ".*\\.proto$"))
               ("dired" (mode . dired-mode))
               ("h" (or
                     (name . ".*\\.h$")
                     (name . ".*\\.hpp$")))
               ("cc" (or
                      (name . ".*\\.cpp$")
                      (name . ".*\\.cc$")
                      (name . ".*\\.c$")))
               ("py" (mode . "python-mode"))
               ("go" (mode . "go-mode"))))))

(use-package ace-jump-mode
  :bind ("C-;" . ace-jump-mode))

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package auto-complete
  :config (progn
            (ac-config-default)
            (global-auto-complete-mode)))

(setq clang-format-style-option "Google")

(use-package clang-format
  :config (add-hook 'before-save-hook
                    (lambda ()
                        (when (eq major-mode 'c++-mode)
                          (clang-format-buffer)))))

(use-package markdown-mode
  :defer t)

(use-package json-mode
  :defer t)

(use-package magit
  :bind (("C-x m" . magit-status)))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package protobuf-mode
  :defer t)

(use-package jedi
  :config (progn
             (add-hook 'python-mode-hook 'jedi:setup)
             (setq jedi:complete-on-dot t)))

;; line utils
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(defun copy-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (move-beginning-of-line 1)
)

;; util commands
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "C-c C-l") 'copy-line)

;; BACKUP files
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Coding modes
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("BUILD" . python-mode))
(add-to-list 'auto-mode-alist '("\\.BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '("WORKSPACE" . python-mode))

(setq inhibit-startup-screen t)

;; General
(setq-default indent-tabs-mode nil)
(menu-bar-mode t)
(tool-bar-mode -1)
(setq-default default-tab-width 2)
(column-number-mode t)
(global-linum-mode t)
(show-paren-mode t)
(electric-pair-mode t)

(add-hook 'before-save-hook 'whitespace-cleanup)

(setq tramp-default-method "sshx")

;; save and restore entire session
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit markdown-mode clang-format auto-complete exec-path-from-shell ace-jump-mode smex json-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
