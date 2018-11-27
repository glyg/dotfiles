;;; glyg --- glyg's Emacs file

;;; Commentary: might not be consumable nor GNU

(set-language-environment "UTF-8")

;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-classic)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (blacken yasnippet-snippets weechat yasnippet yaml-mode writeroom-mode scad-mode python-mode neotree multiple-cursors markdown-preview-eww markdown-mode+ jedi flycheck find-file-in-repository cython-mode autopair anaconda-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized t)
(load-library "iso-transl")
;;

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Overwrite in selection mode
(delete-selection-mode t)
;; column numbers
(column-number-mode t)

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
(setq-default delete-old-versions t)

;; supplementary auto-modes

(setq auto-mode-alist (append '(("\\.svg"  . xml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.i"  . c++-mode)) auto-mode-alist))
(setq-default ispell-program-name "aspell")
(setq auto-mode-alist (cons '("\\.m\\'" . octave-mode) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.md"  . markdown-mode)) auto-mode-alist))



(electric-pair-mode 1)
'(markdown-enable-math t)
(defvar markdown-electric-pairs '((?` . ?`)) "Electric pairs for markdown-mode.")
(defun markdown-add-electric-pairs ()
  (setq-local electric-pair-pairs (append electric-pair-pairs markdown-electric-pairs))
  (setq-local electric-pair-text-pairs electric-pair-pairs))

(add-hook 'markdown-mode-hook 'markdown-add-electric-pairs)
;; Use visual-line-mode in gfm-mode
(defun md-vlm-mode-hook ()
  (visual-line-mode 1)
  (visual-fill-column-mode t))
(add-hook 'markdown-mode-hook 'md-vlm-mode-hook)
(add-hook 'LaTex-mode-hook 'md-vlm-mode-hook)


;; Remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; pour inserer l'entete de mes .pelican
(defun tv-insert-pelican-header ()
  "insert pelican MarkDown header at point"
  (interactive)
  (insert "title:\n"
	  "slug:\n"
	  "date:\n"
	  "tags:\n"
	  "summary:\n"))
(global-set-key (kbd "C-c e m") 'tv-insert-pelican-header)

(add-hook 'markdown-mode-hook 'electric-pair-mode)


(require 'uniquify) ; bundled with GNU emacs 23.2.1 or before. On in 24.4
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; cat.png<dirName>


;; Package manager
(require 'package)
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; (package-refresh-contents)
(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

;; ;; make more packages available with the package installer
(setq to-install
      '(python-mode yasnippet jedi auto-complete find-file-in-repository flycheck anaconda-mode))

(mapc 'install-if-needed to-install)

;; (require 'magit)
;; (global-set-key "\C-xg" 'magit-status)

(require 'auto-complete)
(require 'yasnippet)
(require 'flycheck)
(global-flycheck-mode t)

(global-set-key [f7] 'find-file-in-repository)

; auto-complete mode extra settings
(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20)

;; ;; Python mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(add-hook 'python-mode-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)


(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'blacken-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default python-indent 4)

(ido-mode t)

;; -------------------- extra nice things --------------------
;; use shift to move around windows
(windmove-default-keybindings 'shift)
(show-paren-mode t)
 ; Turn beep off
(setq visible-bell nil)

;; multiple cursors

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (load-file "/home/guillaume/Dev/flycheck-grammalecte/flycheck-grammalecte.el")

(provide '.emacs)
;;; .emacs ends here
