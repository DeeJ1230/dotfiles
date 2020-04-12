;; (setq url-proxy-services '(("no_proxy" . "work\\.com")
;;                            ("http" . "USER:PASSWORD@proxy:port")
;;                            ("https" . "USER:PASSWORD@proxy:port")))

; ========== Enable package mode ==========
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(setq package-list '(;; themes
                     autumn-light-theme
                     base16-theme
                     dark-krystal-theme
                     github-modern-theme
                     twilight-bright-theme
                     ;; navigation, search
                     helm
                     helm-projectile
                     org-projectile
                     dired-icon
                     ;; development
                     flycheck
                     go-mode
                     intero
                     ; haskell-mode
                     ; idris-mode
                     json-mode
                     magit
                     markdown-mode
                     ; nix-mode
                     protobuf-mode
                     toml-mode
                     yaml-mode))

;; rm -rf ~/.emacs.d/elpa to reload
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; Re-map annoying C-z
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z C-z") 'my-suspend-frame)
(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

;; ========== Projectile =========
(global-set-key "\C-xp" 'helm-projectile)

;; ========== Editor =========
(global-set-key "\C-c$" 'toggle-truncate-lines)

;; ========== Org mode ==========
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
;; List of supported languages: https://orgmode.org/org.html#Languages
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)) ) ;; enable shell for execution
(setq org-confirm-babel-evaluate nil)
(require 'ox-latex)
(require 'ox-beamer)
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; ========== EDiff ==========
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ========== Default Browser ==========
(setq browse-url-browser-function 'browse-url-firefox)
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "brave")

;; ========== Default Shell =========
;; (setq explicit-shell-file-name "/bin/bash")

;; ========== Helm ==========
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") #'helm-select-action)

;; ========== Haskell mode ==========
(require 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)
(add-hook 'haskell-mode-hook
    '(lambda ()
       (local-set-key "\M-," 'intero-goto-definition)))

;; ========== Magit ==========
(require 'magit)

;; ========== Markdown mode ==========
(require 'markdown-mode)

;; ========== Protobuf mode ==========
(require 'protobuf-mode)

;; ========== Yaml mode ==========
(require 'yaml-mode)

;; ========== UI look & feel ==========

;; (defmacro with-system (type &rest body)
;;   "Evaluate body if `system-type' equals type."
;;   `(when (eq system-type ,type)
;;      ,@body))
;; (with-system 'gnu/linux
;;   (set-frame-font "NotoSansMono Nerd Font-14"))
;; (with-system 'windows-nt
;;   (set-frame-font "-outline-Noto Sans Mono-normal-normal-normal-mono-16-*-*-*-p-*-ascii-0"))

;; Answer from [https://stackoverflow.com/a/33458674] on how to set font when running with server
(defun frame-font-setup
    (&rest ...)
  ;; (remove-hook 'focus-in-hook #'frame-font-setup)
  (unless (assoc 'font default-frame-alist)
    (let* ((font-family (catch 'break
                          (dolist (font-family
                                   '("Noto Sans Mono"
                                     "NotoSansMono Nerd Font"
                                     ;;
                                     "Powerline Consolas"
                                     "Consolas for Powerline"
                                     "Consolas"
                                     ;;
                                     "Powerline Inconsolata-g"
                                     "Inconsolata-g for Powerline"
                                     "Inconsolata-g"
                                     ;;
                                     "Powerline Source Code Pro"
                                     "Source Code Pro for Powerline"
                                     "Source Code Pro"
                                     ;;
                                     "Powerline DejaVu Sans Mono"
                                     "DejaVu Sans Mono for Powerline"
                                     "DejaVu Sans Mono"
                                     ;;
                                     "Monospace"))
                            (when (member font-family (font-family-list))
                              (throw 'break font-family)))))
           (font (when font-family (format "%s-12" font-family))))
      (when font
        (add-to-list 'default-frame-alist (cons 'font font))
        (set-frame-font font t t)))))
(add-hook 'focus-in-hook #'frame-font-setup)

(customize-set-variable 'inhibit-startup-screen t) ; no splash screen on start
(tool-bar-mode -1) ; No tool bar with icons
(scroll-bar-mode -1) ; No scroll bars
(menu-bar-mode -1) ; No menu bar
(load-theme 'twilight-bright t)

;; ===== Set the highlight current line minor mode =====
(global-hl-line-mode 0) ;; In every buffer, the line which contains the cursor will be fully highlighted

;; ===== Set standard indent to 2 rather that 4 ====
(setq standard-indent 2)
;; (customize-set-variable 'indent-tabs-mode nil)
;; (customize-set-variable 'standard-indent 2)
;; (customize-set-variable 'tab-width 2)
;; (customize-set-variable 'tab-stop-list '(2 4 8 12))

;; ===== Turn off tab character =====
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
(setq-default indent-tabs-mode nil)

;; ========== Line by line scrolling ==========
;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing
(setq scroll-step 1)

;; ========== Support Wheel Mouse Scrolling ==========
(mouse-wheel-mode t)

;; ========== Place Backup Files in Specific Directory ==========
;; (setq make-backup-files t) ;; Enable backup files.
;; (setq version-control t) ;; Enable versioning with default values (keep five last versions, I think!)
;; (setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/")))) ;; Save all backup file in this directory.

;; ===== Turn on Auto Fill mode automatically in all modes =====
;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.
;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.
(setq auto-fill-mode 1)

;; ============ Ignore case on C-x C-f =============
(setq read-file-name-completion-ignore-case t)

;; ========= Setup mode-specific hooks ==========
;; (defun configure-python-mode
;;   (setq python-indent-offset 2))
;; (add-hook 'python-mode-hook 'configure-python-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'haskell-mode-hook 'linum-mode)
(add-hook 'yaml-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'dired-mode-hook 'dired-icon-mode)

;; ========= Tweaking mode line ==========
(display-time-mode t) ; show time in mode line
(display-battery-mode 1) ; show battery status in mode line

;; ========= The rest ==========
