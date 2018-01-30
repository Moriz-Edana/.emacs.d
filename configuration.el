
(add-to-list 'load-path "~/.emacs.d/lisp")

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  )

(setq user-full-name "Bryan W. Roberts"
      user-mail-address "b.w.roberts@lse.ac.uk"
      calendar-latitude 51.5
      calendar-longitude -0.1
      calendar-location-name "London, UK")

;; -*- mode: elisp -*-
(require 'org)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) ;; Make Org mode work with files ending in .org

(require 'org-bullets)
(add-hook 'org-mode-hook
   (lambda ()
      (org-bullets-mode 1)))

(setq org-hide-leading-stars t)

(setq org-ellipsis " ∇")

(setq org-src-fontify-natively t)

(setq org-src-tab-acts-natively t)

(setq org-src-window-setup 'current-window)

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(require 'ox-md)
(require 'ox-beamer)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (dot . t)
   (gnuplot . t)))

(setq org-confirm-babel-evaluate nil)

(setq org-export-with-smart-quotes t)

(setq org-html-postamble nil)

(global-visual-line-mode t)

(setq inhibit-startup-message t) ; no more welcome screen
(global-linum-mode 1) ; linenumbers
(setq linum-format "%d  ") ; linenumber format
(setq-default cursor-type 'bar) ; make cursor a vertical bar
(blink-cursor-mode 1) ; blink the cursor
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (yasnippet web-mode sublime-themes pdf-tools parsebib pandoc multiple-cursors helm dash csv-mode color-theme auctex-latexmk)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))
 ; full screen
(require 'paren) ; highlight open/closed parentheses
(show-paren-mode 1) ; turn parentheses mode on, always
(setq show-paren-delay 0) ; show the paren match immediately
(setq Tex-auto-global nil) ; for faster load time
(setq Tex-macro-global nil) ; for faster load time
;; custom theme (use melpa to install color-theme package)
(require 'color-theme) ;theme
(color-theme-initialize) ;theme
(load-file "~/.emacs.d/lisp/themes/montekai.el") ;theme
(montekai) ;theme
;; scroll up/down a line with up and down arrows ;;
(global-set-key [up] (lambda () (interactive) (scroll-down 1)))
(global-set-key [down] (lambda () (interactive) (scroll-up 1)))
;; open recent files with C-x C-r
(require 'recentf) ;; Obtain a list of recent files wiht C-x C-r
(recentf-mode 1)
(setq recentf-max-menu-items 15)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(require 'multiple-cursors) ;; Multiple cursors package!
(global-set-key (kbd "\C-c m") 'mc/edit-lines) ;; multiple cursors cmd

(require 'centered-window-mode) ;; Centred window mode package for centering text

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Make symbols prettier
(global-prettify-symbols-mode t)

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "£")))

;; Things that don't work/matter in the Terminal ;;
 (if (display-graphic-p)
     (progn
     ;; Graphic Display Only Code
       (set-face-attribute 'default nil :height 160) ;font-size
       (tool-bar-mode -1) ;no toolbar
       (set-frame-parameter (selected-frame) 'alpha '(92 90)) ;transparency
       (add-to-list 'default-frame-alist '(alpha 92 90)) ;transparency
       ;;get emacs to find the right path to latex
       ;; (setenv "PATH"
       ;;    (concat
       ;;           "/usr/texbin" ":"
       ;;           "/usr/local/bin" ":"
       ;;           "/usr/local/texlive/2015/bin" ":"
       ;;            (getenv "PATH")
       ;;         ))
       (setq exec-path (append exec-path '("/usr/local/bin")))
     )
     ;; else (optional)
)
(put 'downcase-region 'disabled nil)

(add-hook 'LaTeX-mode-hook
   '(lambda ()
        (define-key LaTeX-mode-map (kbd "s-i") (kbd "\C-c \C-f \C-e"))
        (define-key LaTeX-mode-map (kbd "s-b") (kbd "\C-c \C-f \C-b"))
    )
)
(add-hook 'markdown-mode-hook
   '(lambda ()
        (define-key markdown-mode-map (kbd "s-i") (kbd "\C-c \C-s e"))
        (define-key markdown-mode-map (kbd "s-b") (kbd "\C-c \C-s s"))
    )
)

(require 'helm-config)
(require 'helm)
(global-set-key (kbd "C-c h") 'helm-command-prefix) ; Make C-c h the Helm command key
(global-unset-key (kbd "C-x c")) ; Unset C-x c which is too close to C-x C-c.
(global-unset-key (kbd "C-z")) ; Unset because I'm always accidentally minimizing and crashing emacs
(global-unset-key (kbd "C-x z")) ; Unset because I'm always accidentally minimizing and crashing emacs
(global-unset-key (kbd "C-x C-z")) ; Unset because I'm always accidentally minimizing and crashing emacs
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp t ; search for library in 'require' and 'declare-function' sexp.
      helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(helm-mode 1)

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setq TeX-auto-save t) ; auto save
(setq TeX-parse-self t) ; auto parse on load
(setq preview-auto-cache-preamble t) ; stop preview pestering
; (setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ; Word wrapping
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t) ; Compile as a PDF
(setq reftex-ref-macro-prompt nil) ; Disable annoying reference prompt screen
(setq reftex-default-bibliography '("/bwrtex/MasterBibliography.bib")) ; So Reftex finds my bib file

;; latexmk - repeat compiling
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; XeLaTeX
(add-hook 'LaTeX-mode-hook (lambda()
    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
))

;option -b highlights the current line in Skim; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b")))
(server-start); start emacs in server mode so that skim can talk to it

; Turn flyspell on for our various modes
(require 'flyspell)
(add-hook 'LaTeX-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
; Keybindings
(define-key flyspell-mode-map (kbd "C-c C-;") 'helm-flyspell-correct)
; Bug fix, to allow saving a word to custom dictionary without having to then start all over
(defun flyspell-buffer-after-pdict-save (&rest _)
  (flyspell-buffer))
(advice-add 'ispell-pdict-save :after #'flyspell-buffer-after-pdict-save)
; Change the colour of highlighted incorrect words
(custom-set-faces
 '(flyspell-incorrect ((((class color)) (:foreground "white" :background "red4" :underline t :weight bold))))
 '(flyspell-duplicate ((((class color)) (:foreground "white" :background "orchid4" :underline t :weight bold))))
 )

;; {{ flyspell setup for web-mode
(defun web-mode-flyspell-verify ()
  (let* ((f (get-text-property (- (point) 1) 'face))
         rlt)
    (cond
     ;; Check the words with these font faces, possibly.
     ;; this *blacklist* will be tweaked in next condition
     ((not (memq f '(web-mode-html-attr-value-face
                     web-mode-html-tag-face
                     web-mode-html-attr-name-face
                     web-mode-constant-face
                     web-mode-doctype-face
                     web-mode-keyword-face
                     web-mode-comment-face ;; focus on get html label right
                     web-mode-function-name-face
                     web-mode-variable-name-face
                     web-mode-css-property-name-face
                     web-mode-css-selector-face
                     web-mode-css-color-face
                     web-mode-type-face
                     web-mode-block-control-face)))
      (setq rlt t))
     ;; check attribute value under certain conditions
     ((memq f '(web-mode-html-attr-value-face))
      (save-excursion
        (search-backward-regexp "=['\"]" (line-beginning-position) t)
        (backward-char)
        (setq rlt (string-match "^\\(value\\|class\\|ng[A-Za-z0-9-]*\\)$"
                                (thing-at-point 'symbol)))))
     ;; finalize the blacklist
     (t
      (setq rlt nil)))
    rlt))
(put 'web-mode 'flyspell-mode-predicate 'web-mode-flyspell-verify)
;; }}
(defvar flyspell-check-doublon t
  "Check doublon (double word) when calling `flyspell-highlight-incorrect-region'.")
 (make-variable-buffer-local 'flyspell-check-doublon)

(defadvice flyspell-highlight-incorrect-region (around flyspell-highlight-incorrect-region-hack activate)
  (if (or flyspell-check-doublon (not (eq 'doublon (ad-get-arg 2))))
      ad-do-it))

(defun web-mode-hook-setup ()
  (flyspell-mode 1)
  (setq flyspell-check-doublon nil))

(add-hook 'web-mode-hook 'web-mode-hook-setup)

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)
;; key bindings
(global-set-key "\M-s\M-s" 'yas-insert-snippet)

;; Requires installing markdown. Just run in the shell:
;; brew install markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'visual-line-mode) ; line wrapping

;; Markdown rendering - better font-sizes
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#272821"))))
 '(markdown-header-delimiter-face ((t (:inherit font-lock-function-name-face :underline t :weight bold))) t)
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.5))) t)
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.3))) t)
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :underline t :height 1.2))) t)
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :underline t :height 1.1))) t)
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :underline t))) t)
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :underline t))) t))
(put 'set-goal-column 'disabled nil)

;; Better Webmode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; SVG viewing and editing
(require 'nxml-mode)
(add-to-list 'rng-schema-locating-files
             "~/.emacs.d/xml-schemas/schemas.xml"
             t)
(define-key nxml-mode-map "\M- " 'completion-at-point)

;; WEB PREVIEW (Does this work?)
;; (require 'html-preview)                      
;; Turn on the minor mode in your source buffer
;; M-x html-preview-minor-mode

;; By default previews are generated only on save.
;; If you wish to enable previews for every change, set
;; ~html-preview-after-change-idle-delay~ to some value in seconds.
;; (setq html-preview-after-change-idle-delay 0.4)

;; Pop-up window crashing emacs
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))