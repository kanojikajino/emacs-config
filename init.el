;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(blackout el-get hydra leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ;; flycheck
;; (leaf flycheck
;;   :doc "On-the-fly syntax checking"
;;   :emacs>= 24.3
;;   :ensure t
;;   :bind (("M-n" . flycheck-next-error)
;;          ("M-p" . flycheck-previous-error))
;;   :custom ((flycheck-emacs-lisp-initialize-packages . t)
;; 	   (flycheck-display-errors-delay . 0.3)
;; 	   (flycheck-indication-mode . 'left-margin)) ;terminalで使うので、fringeではなくmarginに警告を表示
;;   :hook (emacs-lisp-mode-hook lisp-interaction-mode-hook prog-mode-hook . flycheck-mode)
;;   :config
;;   (leaf flycheck-package
;;     :doc "A Flycheck checker for elisp package authors"
;;     :ensure t
;;     :config
;;     (flycheck-package-setup))
;;   (leaf flycheck-elsa
;;     :doc "Flycheck for Elsa."
;;     :emacs>= 25
;;     :ensure t
;;     :config
;;     (flycheck-elsa-setup))
;;   (leaf flycheck-inline
;;     :ensure t
;;     :hook (flycheck-mode-hook . flycheck-inline-mode))
;;   (add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode) ; flycheckのみでmarginを使用
;; )
					;

; parenthese
(leaf smartparens
  :ensure t
  :hook (after-init-hook . smartparens-global-strict-mode) ; strictモードを有効化
  :require smartparens-config
  :custom ((electric-pair-mode . nil))) ; electirc-pair-modeを無効化

(leaf rainbow-delimiters
  :ensure t
  :hook
  ((prog-mode-hook       . rainbow-delimiters-mode)))

					; python
(leaf py-isort :ensure t)

					; python completion

(leaf company
  :ensure t
  :leaf-defer nil
  :blackout company-mode
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("C-i" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-tooltip-limit         . 12)
           (company-idle-delay            . 0) ;; 補完の遅延なし
           (company-minimum-prefix-length . 1) ;; 1文字から補完開始
           (company-transformers          . '(company-sort-by-occurrence))
           (global-company-mode           . t)
           (company-selection-wrap-around . t))
  )

					; magit
(leaf magit
  :bind (("C-x g" . magit-status))
  :ensure t
  :custom
  `((magit-completing-read-function . 'magit-builtin-completing-read)
    (magit-refs-show-commit-count   . 'all)
    (magit-log-buffer-file-locked   . t)
    (magit-revision-show-gravatars  . nil)
    )
  )

; divide display into three
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x@" '(lambda ()
			   (interactive)
			   (split-window-vertically-n 3)))
(global-set-key "\C-x#" '(lambda ()
			   (interactive)
			   (split-window-horizontally-n 3)))

; window move
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)
