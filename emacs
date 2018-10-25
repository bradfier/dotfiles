
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar packagelist
  '(pyenv-mode
    elpy
    company
    helm
    helm-projectile
    rust-mode
    rustfmt
    racer
    go-mode
    company-go
    color-theme-sanityinc-tomorrow
    yaml-mode
    magit))

(mapc #'(lambda (package)
  (unless (package-installed-p package)
    (package-install package)))
    packagelist)
    
           
;; Helm first
(require 'helm-config)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

;; Go stuff (it's picky)
(setenv "GOPATH" "/home/bradfier/go")

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(defun my-go-mode-hook ()
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)



;; C/C++ Stuff
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
    'company-mode)

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; Rust
(add-hook 'rust-mode-hook 'racer-mode)

;; Python
(elpy-enable)
(pyenv-mode)

(setq elpy-rpc-backend "jedi")
(setenv "WORKON_HOME" "/home/bradfier/.cache/pypoetry/virtualenvs/")
    
;; Get rid of annoying temp files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-xcode company-cmake company-capf company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev)))
 '(company-go-gocode-command "/home/bradfier/go/bin/gocode")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quotexe
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(exec-path
   (quote
    ("/usr/local/sbin" "/usr/local/bin" "/usr/bin" "/usr/bin/site_perl" "/usr/bin/vendor_perl" "/usr/bin/core_perl" "/usr/lib/emacs/25.1/x86_64-unknown-linux-gnu" "/home/bradfier/go/bin")))
 '(godef-command "godef")
 '(irony-additional-clang-options (quote ("-DDEBUG")))
 '(package-selected-packages
   (quote
    (projectile-ripgrep helm-projectile pyenv-mode elpy lsp-rust lsp-mode helm rustfmt racer rust-mode cmake-mode company-irony irony yaml-mode magit company-go go-mode company color-theme-sanityinc-tomorrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d1f21" :foreground "#c5c8c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "PfEd" :family "Fantasque Sans Mono")))))


(color-theme-sanityinc-tomorrow-night)

;; Autostart
(server-start)
