;; Added by Package.el.This must come before configurations of
;; installed packages.Don 't delete this line.  If you don' t want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("marmalade"."http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa"."http://melpa.milkbox.net/packages/"))
(package-initialize)

;; PATH
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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

;; BACKUP files
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; util commands
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "C-c C-l") 'copy-line)

;; General
(setq-default indent-tabs-mode nil)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("BUILD" . python-mode))
(add-to-list 'auto-mode-alist '("\\.BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '("WORKSPACE" . python-mode))

(global-set-key [C-M-tab] 'clang-format-buffer)

(defun my-c++-mode-before-save-hook ()
  (when (eq major-mode 'c++-mode)
    (clang-format-buffer)))

(add-hook 'before-save-hook #'my-c++-mode-before-save-hook)

(setq clang-format-style-option "Google")

;; color-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/twilight-theme")
(load-theme 'twilight t)

(setq inhibit-startup-screen t)

;; menu bar is useful when getting started
(menu-bar-mode t)
(tool-bar-mode -1)
(setq-default default-tab-width 2)
(column-number-mode t)
(global-linum-mode t)
(show-paren-mode t)
(global-auto-complete-mode t)

;; install smex via package
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ido mode for finding files and buffers
(ido-mode t)

;; auto complete pairs
(electric-pair-mode t)

;; use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . ".*\\.el$")))
               ("build" (or
                         (name . "BUILD")
                         (name . "WORKSPACE")))
               ("dired" (mode . dired-mode))
               ("h" (or
                     (name . ".*\\.h$")
                     (name . ".*\\.hpp$")))
               ("cc" (or
                      (name . ".*\\.cpp$")
                      (name . ".*\\.cc$")
                      (name . ".*\\.c$")))
               ("py" (mode . "python-mode"))))))

(add-hook 'ibuffer-mode-hook
         (lambda ()
           (ibuffer-switch-to-saved-filter-groups "default")))

;; GO
;; (setenv "GOPATH" "/Users/alan/Workspace/go")
;; (add-to-list 'exec-path "/usr/local/go/bin")
;; ;;(add-hook 'before-save-hook 'gofmt-before-save)

;; (defun auto-complete-for-go ()
;;   (auto-complete-mode 1))
;; (add-hook 'go-mode-hook 'auto-complete-for-go)

;; (defun auto-complete-for-go ()
;; (auto-complete-mode 1))
;; (add-hook 'go-mode-hook 'auto-complete-for-go)

;; ;; (with-eval-after-load 'go-mode
;; ;;    (require 'go-autocomplete))

;; (defun my-go-mode-hook ()
;;   ; Use goimports instead of go-fmt
;;   (setq gofmt-command "goimports")
;;   ; Call Gofmt before saving
;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   ; Customize compile command to run go build
;;   (if (not (string-match "go" compile-command))
;;       (set (make-local-variable 'compile-command)
;;            "go generate && go build -v && go test -v && go vet"))
;;   ; Go oracle
;;   (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
;;   ; Godef jump key binding
;;   (local-set-key (kbd "M-.") 'godef-jump)
;;   (local-set-key (kbd "M-*") 'pop-tag-mark)
;; )
;; (add-hook 'go-mode-hook 'my-go-mode-hook)

;; save and restore entire session
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (exec-path-from-shell clang-format magit smex markdown-mode go-mode go-autocomplete color-theme-twilight ace-jump-mode)))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
