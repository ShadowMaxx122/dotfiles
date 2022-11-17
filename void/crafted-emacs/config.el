;; This config is managed via org file. Edit that file instead.

(setq erc-server "irc.libera.chat"
      erc-nick "shadowmaxx122"    ; Change this!
      erc-user-full-name "Jacob"  ; And this!
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc.libera.chat" "#systemcrafters" "#emacs"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury)

(crafted-package-install-package 'aggressive-indent)
(global-aggressive-indent-mode 1)



(require 'use-package)

(require 'crafted-defaults)
  (require 'crafted-pdf-reader)
  (require 'crafted-speedbar)
  (require 'crafted-lisp)
  (require 'crafted-startup)
(require 'org)
  ;;(unbind-key "C-," org-mode-map)
  ;;(unbind-key "C-'" org-mode-map)


  (crafted-package-install-package 'vterm)
  (crafted-package-install-package 'xterm-color)

  (setq vterm-max-scrollback 10000)

  ;; (setup (:pkg exec-path-from-shell)
  ;;        (setq exec-path-from-shell-check-startup-files nil)
  ;;        (when (memq window-system '(mac ns x))
  ;;          (exec-path-from-shell-initialize)))

(require 'crafted-ui)

(crafted-package-install-package 'emojify)
(crafted-package-install-package 'all-the-icons)
(crafted-package-install-package 'unicode-fonts)
(crafted-package-install-package 'which-key)
(which-key-mode)

(doom-modeline-mode 1)

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

(require 'crafted-evil)

;; Set configuration variables
(custom-set-variables '(crafted-evil-discourage-arrow-keys t)
                      '(evil-want-C-u-scroll t))

;; Set preferred key bindings
(global-set-key (kbd "M-/") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-M-u") 'universal-argument)

(require 'crafted-completion)

(define-key vertico-map (kbd "C-f") 'vertico-exit)
(define-key minibuffer-local-map (kbd "C-d") 'embark-act)
(define-key project-prefix-map (kbd "g") 'consult-ripgrep)

(global-set-key (kbd "C-M-j") 'consult-buffer)

(require 'crafted-project)

;;; Source Control

(crafted-package-install-package 'magit)

(global-set-key (kbd "C-M-;") #'magit-status)

(require 'crafted-ide)

(crafted-package-install-package 'typescript-mode)
(crafted-package-install-package 'lsp-mode)

;;; Lisp Editing

(require 'crafted-lisp)

(require 'crafted-editing)
(crafted-package-install-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(eval-after-load "web-mode"
  '(setq web-mode-tag-auto-close-style 1))

(require 'crafted-org)

(with-eval-after-load 'org
  (require 'tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  (unbind-key "C-," org-mode-map)
  (unbind-key "C-'" org-mode-map))

;; (require 'org-bullets
;;   :hook (org-mode . org-bullets-mode)
;;   :custom
;;   (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(crafted-package-install-package 'org-auto-tangle)
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(crafted-package-install-package 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-startup-indented t)           ;; Indent according to section
(setq org-startup-with-inline-images t) ;; Display images in-buffer by default

(crafted-package-install-package 'avy)
;; (global-set-key (kbd "C-:") nil)
;; (global-set-key (kbd "C-:") 'avy-goto-char-2)
;; (global-set-key (kbd "M-g f") 'avy-goto-line)
;;   (avy-setup-default)
;;   (global-set-key (kbd "C-c C-j") 'avy-resume)
;;   (global-set-key (kbd "C-:") 'avy-goto-char-2)
;;   (global-set-key (kbd "M-g e") 'avy-goto-word-0)
;; (setq avy-case-fold-search nil)       ;; case sensitive makes selection easier
(bind-key "C-;"    'avy-goto-char-2)  ;; I use this most frequently
(bind-key "C-'"    'avy-goto-line)    ;; Consistent with ivy-avy
(bind-key "M-g c"  'avy-goto-char)
(bind-key "M-g e"  'avy-goto-word-0)  ;; lots of candidates
(bind-key "M-g g"  'avy-goto-line)    ;; digits behave like goto-line
(bind-key "M-g w"  'avy-goto-word-1)  ;; first character of the word
(bind-key "M-g P"  'avy-pop-mark)
