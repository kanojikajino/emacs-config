;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(add-to-list 'load-path "emacs-flycheck-mypy")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
        (eval-print-last-sexp)))

;(el-get-bundle elpa:w3m)
;(setq w3m-imagick-convert-program nil)


(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'display-buffer-alist
	     '("^\\*shell\\*$" . (display-buffer-same-window)))


;(eval-after-load 'company
;  '(add-to-list 'company-backends 'company-irony))

; magit
;(el-get-bundle magit)

; fish
;(el-get-bundle emacs-fish)
					;company mode
(el-get-bundle company-mode/company-mode)
(global-company-mode +1)
;; 自動補完を offにしたい場合は, company-idle-delayを nilに設定する
;; auto-completeでいうところの ac-auto-start にあたる.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay nil)
 '(package-selected-packages (quote (org-edna w3m))))
(set-face-attribute 'company-tooltip nil
		    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
		    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
		    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
		    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
		    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
		    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
		    :background "gray40")
(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

					; jedi
(el-get-bundle auto-complete)
;(el-get-bundle company-jedi)
(el-get-bundle jedi-core)
(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
;(add-hook 'python-mode-hook 'company-jedi)
(add-to-list 'company-backends 'company-jedi)
;(require 'jedi-core)
;(setq jedi:complete-on-dot t)
;(setq jedi:use-shortcuts t)
;(add-hook 'python-mode-hook 'jedi:setup)

; pep8
(el-get-bundle python-pep8)

;(el-get-bundle company-jedi)
;(el-get-bundle jedi-core)
;(el-get-bundle jedi)
;(require 'jedi-core)
;(setq jedi:complete-on-dot t)
;(setq jedi:use-shortcuts t)
;(add-hook 'python-mode-hook 'jedi:setup)
					;(add-to-list 'company-backends 'company-jedi) ; backendに追加
(setq jedi:get-in-function-call-delay 0)

; yatex
(el-get-bundle yatex :type hg :url "http://www.yatex.org/hgrepos/yatex" :branch "dev")
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "pdflatex -synctex=1")
(setq tex-pdfview-command "open -a Preview")
(setq dvi2-command "open -a Preview")

; reftex
(el-get-bundle reftex)
(add-hook 'yatex-mode-hook 'turn-on-reftex)
(setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil)))

; template
(setq auto-insert-directory "~/.emacs.d/template/")
(setq auto-insert-query nil)
(define-auto-insert "\\.py\\'" "template.py")
(define-auto-insert "\\.sh\\'" "template.sh")
(add-hook 'find-file-hooks 'auto-insert)


; aspell
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
   '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

; flyspell
(el-get-bundle flyspell)
(add-hook 'yatex-mode-hook 'flyspell-mode)
;(mapc
; (lambda (hook)
;   (add-hook hook
;	     '(lambda () (flyspell-mode 1))))
; '(
;   yatex-mode-hook
;      ))

; hs-headline
(add-hook 'python-mode-hook '(lambda () (hs-minor-mode 1)))     

; quickrun
(el-get-bundle quickrun)
(global-set-key (kbd "<f5>") 'quickrun)

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

; auto completion
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map "\"" 'electric-pair)
	    (define-key python-mode-map "\'" 'electric-pair)
	    (define-key python-mode-map "(" 'electric-pair)
	    (define-key python-mode-map "[" 'electric-pair)
	    (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

					; markdown
;(add-to-list 'exec-path "/usr/local/opt/w3m/bin/")
;(el-get-bundle elpa:w3m)
(el-get-bundle markdown-mode)
(require 'markdown-mode)
;(require 'w3m)
;(define-key markdown-mode-map (kbd "\C-c \C-c \C-v")
;  (lambda ()
;    (interactive)
;    (setq html-file-name (concat (file-name-sans-extension (buffer-file-name)) ".html"))
;    (markdown-export html-file-name)
;    (if (one-window-p) (split-window))
;    (other-window 1)
;    (w3m-find-file html-file-name)))

;(require 'markdown-mode)
;(require 'w3m)
;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;(define-key markdown-mode-map "\C-c\C-cm"
;  (lambda ()
;    (interactive)
;    (w3m-find-file (buffer-file-name))))

(add-hook 'python-mode-hook
	  '(lambda ()
	     (hs-minor-mode 1)))
(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

; cython
(el-get-bundle cython-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; racerやrustfmt、コンパイラにパスを通す
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
;;; rust-modeでrust-format-on-saveをtにすると自動でrustfmtが走る
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
;;; rustのファイルを編集するときにracerとflycheckを起動する
(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
;;; racerのeldocサポートを使う
(add-hook 'racer-mode-hook #'eldoc-mode)
;;; racerの補完サポートを使う
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             ;;; この辺の設定はお好みで
                             (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))
(el-get-bundle flycheck)
;(require 'flycheck-mypy)
(require 'flycheck)
(flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports" "--fast-parser"
              "--python-version" "3.6"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)

(add-to-list 'flycheck-checkers 'python-mypy t)
(flycheck-add-next-checker 'python-pylint 'python-mypy t)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (flycheck-mode 1)))

(el-get-bundle ein)
(require 'ein)

;; rainbow-delimiters を使うための設定
(el-get-bundle rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

(package-initialize)
