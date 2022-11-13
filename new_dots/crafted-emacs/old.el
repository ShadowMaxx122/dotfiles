;; Core Settings

(require 'crafted-defaults)

;;; Set up C-SPC prefix map

(defalias 'ctl-spc-keymap (make-sparse-keymap))

(defvar ctl-spc-map (symbol-function 'ctl-spc-keymap)
  "Global keymap for characters following C-SPC.")

(define-key global-map (kbd "C-SPC") 'ctl-spc-keymap)

;;; User Interface

(require 'crafted-ui)

(crafted-package-install-package 'emojify)
(crafted-package-install-package 'all-the-icons)
(crafted-package-install-package 'unicode-fonts)

;; Install minions
(crafted-package-install-package 'minions)
(add-hook 'doom-modeline-mode-hook 'minions-mode)

;; Install doom-themes and set the theme
(crafted-package-install-package 'doom-themes)
(disable-theme 'deeper-blue)
(load-theme 'doom-palenight t)

(custom-set-faces '(mode-line ((t (:height 150))))
                  '(mode-line-inactive ((t (:height 150)))))

;; Set configuration variables
(custom-set-variables '(crafted-ui-display-line-numbers t)
                      '(doom-modeline-height 35))

;;; Evil Mode

(require 'crafted-evil)

;; Set configuration variables
(custom-set-variables '(crafted-evil-discourage-arrow-keys t)
                      '(evil-want-C-u-scroll t))

;; Set preferred key bindings
(global-set-key (kbd "M-/") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-M-u") 'universal-argument)

;;; Completions and Actions

(require 'crafted-completion)

(define-key vertico-map (kbd "C-f") 'vertico-exit)
(define-key minibuffer-local-map (kbd "C-d") 'embark-act)
(define-key project-prefix-map (kbd "g") 'consult-ripgrep)

(global-set-key (kbd "C-M-j") 'consult-buffer)

;;; Project Management

(require 'crafted-project)

;;; Source Control

(crafted-package-install-package 'magit)
(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

(global-set-key (kbd "C-M-;") #'magit-status)

;;; Org Mode

;; Turn on variable pitch for non-monospace fonts
(variable-pitch-mode 1)

;;; Presentations

(require 'crafted-screencast)

;;; IDE

(require 'crafted-ide)

(crafted-package-install-package 'typescript-mode)

;;; Lisp Editing

(require 'crafted-lisp)

;;; Shells

(crafted-package-install-package 'vterm)
(crafted-package-install-package 'xterm-color)

(setq vterm-max-scrollback 10000)

;; Configure vterm for evil-mode
(with-eval-after-load 'evil
  ;; Make sure that entering insert mode positions the cursor correctly
  (advice-add 'evil-collection-vterm-insert :before #'vterm-reset-cursor-point))

(defun read-file (file-path)
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))

(defun dw/get-current-package-version ()
  (interactive)
  (let ((package-json-file (concat (eshell/pwd) "/package.json")))
    (when (file-exists-p package-json-file)
      (let* ((package-json-contents (read-file package-json-file))
             (package-json (ignore-errors (json-parse-string package-json-contents))))
        (when package-json
          (ignore-errors (gethash "version" package-json)))))))

(defun dw/map-line-to-status-char (line)
  (cond ((string-match "^?\\? " line) "?")))

(defun dw/get-git-status-prompt ()
  (let ((status-lines (cdr (process-lines "git" "status" "--porcelain" "-b"))))
    (seq-uniq (seq-filter 'identity (mapcar 'dw/map-line-to-status-char status-lines)))))

(defun dw/get-prompt-path ()
  (let* ((current-path (eshell/pwd))
         (git-output (shell-command-to-string "git rev-parse --show-toplevel"))
         (has-path (not (string-match "^fatal" git-output))))
    (if (not has-path)
        (abbreviate-file-name current-path)
      (string-remove-prefix (file-name-directory git-output) current-path))))

;; This prompt function mostly replicates my custom zsh prompt setup
;; that is powered by github.com/denysdovhan/spaceship-prompt.
(defun dw/eshell-prompt ()
  (let ((current-branch (magit-get-current-branch))
        (package-version (dw/get-current-package-version)))
    (concat
     "\n"
     (propertize (system-name) 'face `(:foreground "#62aeed"))
     (propertize " ॐ " 'face `(:foreground "white"))
     (propertize (dw/get-prompt-path) 'face `(:foreground "#82cfd3"))
     (when current-branch
       (concat
        (propertize " • " 'face `(:foreground "white"))
        (propertize (concat " " current-branch) 'face `(:foreground "#c475f0"))))
     (when package-version
       (concat
        (propertize " @ " 'face `(:foreground "white"))
        (propertize package-version 'face `(:foreground "#e8a206"))))
     (propertize " • " 'face `(:foreground "white"))
     (propertize (format-time-string "%I:%M:%S %p") 'face `(:foreground "#5a5b7f"))
     (if (= (user-uid) 0)
         (propertize "\n#" 'face `(:foreground "red2"))
       (propertize "\nλ" 'face `(:foreground "#aece4a")))
     (propertize " " 'face `(:foreground "white")))))


(add-hook 'eshell-banner-load-hook
          (lambda ()
            (setq eshell-banner-message
                  (concat "\n" (propertize " " 'display (create-image "~/.dotfiles/.emacs.d/images/flux_banner.png" 'png nil :scale 0.2 :align-to "center")) "\n\n"))))

(defun dw/eshell-configure ()
  ;; Make sure magit is loaded
  (require 'magit)

  (require 'evil-collection-eshell)
  (evil-collection-eshell-setup)

  (require 'xterm-color)

  (push 'eshell-tramp eshell-modules-list)
  (push 'xterm-color-filter eshell-preoutput-filter-functions)
  (delq 'eshell-handle-ansi-color eshell-output-filter-functions)

  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  (add-hook 'eshell-before-prompt-hook
            (lambda ()
              (setq xterm-color-preserve-properties t)))

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; We want to use xterm-256color when running interactive commands
  ;; in eshell but not during other times when we might be launching
  ;; a shell command to gather its output.
  (add-hook 'eshell-pre-command-hook
            (lambda () (setenv "TERM" "xterm-256color")))
  (add-hook 'eshell-post-command-hook
            (lambda () (setenv "TERM" "dumb")))

  ;; Use completion-at-point to provide completions in eshell
  (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)

  ;; Initialize the shell history
  (eshell-hist-initialize)

  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'consult-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setenv "PAGER" "cat")

  (setq eshell-prompt-function      'dw/eshell-prompt
        eshell-prompt-regexp        "^λ "
        eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-highlight-prompt t
        eshell-scroll-to-bottom-on-input t
        eshell-prefer-lisp-functions nil))

(add-hook 'eshell-first-time-mode-hook #'dw/eshell-configure)
(setq eshell-directory-name "~/.dotfiles/.emacs.d/eshell/"
      eshell-aliases-file (expand-file-name "~/.dotfiles/.emacs.d/eshell/alias"))

;; (setup (:pkg exec-path-from-shell)
;;        (setq exec-path-from-shell-check-startup-files nil)
;;        (when (memq window-system '(mac ns x))
;;          (exec-path-from-shell-initialize)))

(defun dw/switch-to-eshell ()
  (interactive)
  (if (project-current)
      (call-interactively #'project-eshell)
    (call-interactively #'eshell)))

(define-key ctl-spc-map (kbd "SPC") #'dw/switch-to-eshell)

;; TODO: These may not be needed
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'typescript-mode-hook 'eglot-ensure)

;; TODO: Bring over org-present config

(crafted-package-install-package 'which-key)
(which-key-mode)

;; Editing

(require 'crafted-editing)
(crafted-package-install-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(eval-after-load "web-mode"
  '(setq web-mode-tag-auto-close-style 1))

(require 'org-tempo)
(require 'crafted-org)

(crafted-package-install-package 'org-bullets)

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))



;; (require 'org-bullets
;;   :hook (org-mode . org-bullets-mode)
;;   :custom
;;   (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
