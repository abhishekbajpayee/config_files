(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 ; '(blink-cursor-mode nil)
 ; '(cua-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

; start package.el with emacs
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
; add MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
; initialize package.el
(package-initialize)
(elpy-enable)

; list of packages to install
(setq package-list '(elpy json-mode multiple-cursors dockerfile-mode matlab-mode))

; fetch the list of available packages
(unless package-archive-contents
  (package-refresh-contents))

; install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; set custom keys
(global-set-key (kbd "C-.") 'compile); compile
(global-set-key "\M-%" 'query-replace)
(global-set-key "\M-?" 'rgrep)
(global-set-key "\M-|" 'comment-region)

(global-set-key "\M-H" 'hs-hide-all)
(global-set-key "\M-h" 'hs-hide-block)
(global-set-key "\M-S" 'hs-show-all)
(global-set-key "\M-s" 'hs-show-block)

(global-set-key "\M-c" 'comment-region)
(global-set-key "\M-C" 'uncomment-region)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(setq compilation-scroll-output t)

;; Use spaces for indentation rather than tabs
(setq-default indent-tabs-mode nil)

;; Use four spaces each tab indentation
(setq tab-width 4)

;; Use four spaces as the basic indentation in C
(setq c-basic-offset 4)

(put 'downcase-region 'disabled nil)

(setq grep-find-command 
  "find . -type f '!' -wholename '*/.svn/*' '!' -wholename '*CMakeFiles*' -print0 | xargs -0 -e grep -nHi -e ")

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(load-library "hideshow")
(add-hook 'c++-mode-hook' (lambda () (hs-minor-mode 1)))

;; (add-to-list 'load-path "~/.emacs.d/matlab-emacs")
;; (load-library "matlab-load")

(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
 (setq matlab-indent-function t)
 (setq matlab-shell-command "matlab")

;; format spec files as json
(add-to-list 'auto-mode-alist '("\\.spec.txt\\'" . json-mode))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("Dockerfile.*\\'" . dockerfile-mode))

(push '("\\*compilation\\*" . (nil (reusable-frames . t))) display-buffer-alist)

; TODO: what is this?
; (add-to-list 'load-path "~/.emacs.d/plugins/cl-lib")
; (require 'cl-lib)
