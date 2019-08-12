;;;========================================================================================
;;;  This file must be named ".emacs" and live in your $HOME directory.
;;;========================================================================================

;;;------------------------------------------------------------------
;;; How to do a multi-file search-and-replace:
;;;   M-x find-dired  ;; regex to find all files
;;;   t               ;; marks all files
;;;   Q               ;; starts a query-replace-regexp
;;;------------------------------------------------------------------


;;;----------------------------------------------------------------------------------------
;;; Consider using these modes:
;;;   glasses-mode -- toggles camel case to underscored words, to improve readability
;;;   subword-mode -- toggles moving to next/previous camel-cased word instead of delimited word
;;;   smartscan-mode -- toggles searcn on identifier at point w/o using isearch
;;;----------------------------------------------------------------------------------------
;;;   C-u M-g M-g -- executes goto-line in the previous buffer, using line number at point in current buffer
;;;----------------------------------------------------------------------------------------

(setq delete-by-moving-to-trash t)

;---------------------------------------------------------------------
;  Locate our e-lisp...
;---------------------------------------------------------------------
(setenv "SITELISP_HOME" "~/site-lisp")
(add-to-list 'load-path (getenv "SITELISP_HOME"))

;============================================
;  Load my functions...
;============================================
(load-library "~/.emacs-fncs.el")

;============================================
;  No GNU Emacs / welcome buffer
;============================================
(setq inhibit-startup-screen t)

;============================================
;  Make buffer column wider in *Buffer List*
;============================================
(setq Buffer-menu-name-width 35)

;============================================
;  Set up Network Proxies, if needed...
;     localhost:3128 is for cntlm
;============================================
(setq url-proxy-services
      '(
        ("www"      . "10.10.115.96:3128")
        ("http"     . "10.10.115.96:3128")
        ("https"    . "10.10.115.96:3128")
        ("no_proxy" . "localhost, *.cac.com, *.creditacceptance.com, 10.10.*, 10.100.*")
        ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; NOTE: Need to run cntlm in order for Emacs package management to work properly at CAC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======================================================
; Package management
;=======================================================
(require 'package)
(setq package-archives nil)
(add-to-list 'package-archives '("gnu"           . "http://elpa.gnu.org/packages/"))
;;; (add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable"  . "http://stable.melpa.org/packages/"))
;;; (add-to-list 'package-archives '("marmalade"     . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa"         . "http://melpa.org/packages/"))

;;; (setq debug-on-error t)
(package-initialize)
;;; (package-refresh-contents)

;============================================
;  Font, colors, sizes, ...
;============================================
;;; (set-default-font "-misc-fixed-bold-r-normal--20-140-100-100-c-100-iso8859-1")
;;; (set-default-font "-*-Terminal-normal-r-*-*-12-90-*-*-c-80-*-oem-")
;;; (set-default-font "-*-Fixedsys-normal-r-*-*-15-112-*-*-c-80-*-ansi-")
;;; (set-default-font "-*-Lucida Sans Typewriter-bold-r-*-*-14-*-*-*-c-*-*-ansi-")
;;; (set-default-font "-*-Lucida Sans Typewriter-bold-r-*-*-11-*-*-*-c-*-*-ansi-")
;;; (set-default-font "-b&h-lucidatypewriter-medium-r-normal-sans-*-120-*-*-*-*-iso8859-1")
;;; (set-default-font "lucidasanstypewriter-10")
;;; (set-default-font "-misc-droid sans mono-medium-r-normal--0-0-0-0-m-0-iso8859-1")
;;; (set-default-font "-b&h-lucidabright-medium-r-normal--10-100-75-75-p-56-iso8859-1")
;;; (set-default-font "-b&h-lucidatypewriter-medium-r-normal-sans-12-100-75-75-m-60-iso8859-1")
;;; (set-default-font "-raster-Fixedsys-normal-r-normal-normal-12-90-96-96-c-80-iso10646-1")
;;; (set-default-font "-*-Terminal-normal-r-*-*-12-90-*-*-c-80-*-oem-")
;;; (set-default-font "-*-Lucida Sans Typewriter-normal-r-*-*-13-*-*-*-c-*-iso8859-1")
;;; (set-default-font "-*-Courier New-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
;;; (set-default-font "-outline-Droid Sans Mono-normal-r-normal-normal-14-*-96-96-c-*-iso8859-1")
;;; (set-default-font "-*-Lucida Console-normal-r-*-*-12-*-*-*-*-*-*-*")
;;; (set-default-font "-b&h-lucidatypewriter-bold-r-normal-sans-8-80-75-75-m-50-iso10646-1")
;;; (set-default-font "-misc-droid sans mono-medium-r-normal--13-0-0-0-m-0-iso8859-1")
;;; (set-default-font "Noto Mono-11")
;;; (set-default-font "Inconsolata-12")
;;; (set-default-font "Droid Sans Mono-10") ;;; 12, 13, 15 are real sizes
;;; (set-default-font "Inconsolata-13") ;; 13, 15 are real sizes
(set-default-font "Source Code Pro-11") ;;; (set-default-font "Source Code Pro-14")


(set-cursor-color     "orange")
(set-mouse-color      "#bf3eff")
;;; (set-foreground-color "Snow2")
;;; (set-background-color "Black")

;--------------------------------------------
; Locate and size main frame...
;--------------------------------------------
;;; (monitor-resize-current-frame 200 100 100 100)

(setq default-tab-width 4)

(put 'downcase-region 'disabled nil)
(put 'upcase-region   'disabled nil)

(require 'expand-region)
(global-set-key (kbd "C-2") 'er/expand-region)

;-------------------------------------------------------
;  Protect scratch buffer from being killed...
;-------------------------------------------------------
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))

;-------------------------------------------------------
;  Provides end-of-line conversions (DOS, UNIX, Mac),
;  whitespace handling.
;-------------------------------------------------------
;;;TODO:FIX (require 'eol-conversion)
(require 'whitespace)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'java-mode-untabify)

;-------------------------------------------------------
;  Use fancy mode line
;-------------------------------------------------------
;;; one-time only:  (all-the-icons-install-fonts)
(require 'doom-modeline)
(require 'all-the-icons)
(require 'octicons)
;;; (require 'fontawesome)
(doom-modeline-init)
(doom-modeline-mode 1)
(setq doom-modeline-icon                     t)
(setq doom-modeline-major-mode-icon          t)
(setq doom-modeline-major-mode-color-icon    t)
(setq doom-modeline-buffer-state-icon        t)
(setq doom-modeline-buffer-modification-icon t)
(setq doom-modeline-bar-width                3)
(setq doom-modeline-minor-modes              t)


;=======================================================
;  Fancy Tabbed buffers
;  ...sloooooooow...
;=======================================================
;;; (require 'centaur-tabs)
;;; (centaur-tabs-mode t)
;;; (setq centaur-tabs-set-icons t)
;;; (global-set-key (kbd "C-c p")  'centaur-tabs-backward)
;;; (global-set-key (kbd "C-c n")  'centaur-tabs-forward)

;=======================================================
;  Used to align columns of text
;  or anything based on a regexp
;=======================================================
(require 'align-words)
(require 'align)

;---------------------------------------------------------------------
;  Special saving on Windoze (mostly) .. remove tabs.
;---------------------------------------------------------------------
(setq indent-tabs-mode nil)


;;; (setq default-process-coding-system  '(undecided-dos . undecided-unix))

;---------------------------------------------------------------------
;  Windoze/Cygwin setup
;---------------------------------------------------------------------
;; Sets your shell to use cygwin's bash, if Emacs finds it's running
;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
;; not already in your Windows Path (it generally should not be).
;;
;; (let* ((cygwin-root "c:/cygwin64")
;;     (cygwin-bin (concat cygwin-root "/bin")))
;;   (when (and (eq 'windows-nt system-type)
;;           (file-readable-p cygwin-root))
;;
;;  (setq exec-path (cons cygwin-bin exec-path))
;;  (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
;;
;;  ;; NT-emacs assumes a Windows shell. Change to bash.
;;  (setq shell-file-name "bash")
;;  (setenv "SHELL" shell-file-name)
;;  (setq explicit-shell-file-name shell-file-name)
;;
;;  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))
;;; (require 'setup-cygwin)

;============================================
;  Shell mode
;============================================
(require 'ansi-color)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;;; (set-face-attribute 'comint-highlight-prompt nil :inherit nil)

;; (defun make-my-shell-output-read-only (text)
;;   "Add to comint-output-filter-functions to make stdout read only in my shells."
;;   (if (member (buffer-name) my-shells)
;;       (let ((inhibit-read-only t)
;;             (output-end (process-mark (get-buffer-process (current-buffer)))))
;;         (put-text-property comint-last-output-start output-end 'read-only t))))
;; (add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

(defun my-shell-setup ()
  (setq comint-scroll-show-maximum-output 'this)
  (setq comint-completion-addsuffix       t)
  (setq comint-eol-on-send                t)
;;;  (setq w32-quote-process-args            ?\")

  (make-variable-buffer-local   'comint-completion-addsuffix)
  (local-set-key '[up]          'comint-previous-input)
  (local-set-key '[down]        'comint-next-input)
  (local-set-key '[(shift tab)] 'comint-next-matching-input-from-input)
)
(setq shell-mode-hook 'my-shell-setup)

(setq process-coding-system-alist
      (cons '("bash" . raw-text-unix) process-coding-system-alist))

;;; (setq shell-prompt-pattern     "^[^#$%>\n]*[#$%>] *")
;;; (setq shell-prompt-pattern "\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ ")
;;; export PS1="\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ "

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

;;;CYGWIN-only (bash)
(shell)

;--------------------------------------------
;  Color themes...
;--------------------------------------------
;;; (require 'solarized-dark-theme)
;;; (require 'gruvbox-theme)
(require 'gruvbox-dark-hard-theme)
;;; (require 'lush-theme)
(setq color-theme-is-global t)
;;; (color-theme-initialize)

;--------------------------------------------
;--  Turn on font-lock colorization
;--------------------------------------------
(cond ((fboundp 'global-font-lock-mode)
       ;; Customize face attributes
       (setq font-lock-face-attributes
         ;; Symbol-for-Face Foreground Background Bold Italic Underline
         '(
           (font-lock-comment-face       "DarkSlateGrey")
           (font-lock-string-face        "DarkGoldenrod3")
           (font-lock-keyword-face       "IndianRed3")
           (font-lock-function-name-face "Magenta")
           (font-lock-variable-name-face "SlateBlue")
           (font-lock-type-face          "DarkGreen")
           (font-lock-constant-face      "Purple")
           ))

;;;           (font-lock-api-face       "LightSlateBlue")
;;;           (font-lock-bold-face      "Aquamarine")
;;;           (font-lock-doc-tag-face   "DarkSeaGreen")
;;;           (font-lock-link-face      "DodgerBlue")
;;;           (font-lock-constant-face  "CornflowerBlue")
;;;           (font-lock-modifier-face  "IndianRed")
;;;           (font-lock-operator-face  "DarkOrchid2")
;;;           (font-lock-private-face   "springgreen4")
;;;           (font-lock-protected-face "springgreen3")
;;;           (font-lock-public-face    "red")


       ;; Load the font-lock package.
       (require 'font-lock)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ))

(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)))

;--------------------------------------------
;--  Incremental highlighting of searches
;--------------------------------------------
;;;TODO:FIX (load-library "ishl.elc")
;;;TODO:FIX (ishl-mode)
;;;TODO:FIX (setq query-replace-highlight t)
;;;TODO:FIX (setq search-highlight        t)

;--------------------------------------------
;--  Cursor jiggling
;--------------------------------------------
(require 'jiggle)
(jiggle-mode t)
(jiggle-searches-too 1)
(setq jiggle-how-many-times 8)


;---------------------------------------------------------------------
;  JavaScript mode setup...
;---------------------------------------------------------------------
;;;TODO:FIX (require 'js3-mode)
;;;TODO:FIX (setq auto-mode-alist (append '(("\\.js$" . js3-mode)) auto-mode-alist))
(require 'prettier-js)
;;; (add-hook 'js3-mode-hook 'prettier-js-mode)
(setq prettier-js-args '(
  "--trailing-comma" "all"
  "--bracket-spacing" "false"
  "--print-width" "120"
  "--tab-width" "4"
  "--use-tab" "false"
  "--single-quote" "false"
  ))

;---------------------------------------------------------------------
;  TypeScript mode setup...
;---------------------------------------------------------------------
(require 'typescript-mode)
(setq auto-mode-alist (append '(("\\.ts$" . typescript-mode)) auto-mode-alist))

;---------------------------------------------------------------------
;  Re-map some keys
;---------------------------------------------------------------------
(global-set-key (kbd "C-C %")   'replace-regexp-region)
(global-set-key (kbd "C-C a")   'align-words-align)
(global-set-key (kbd "C-C c")   'comment-region)
(global-set-key (kbd "C-C d")   'delete-trailing-whitespace)
(global-set-key (kbd "C-C e")   'eval-buffer)
(global-set-key (kbd "C-C f")   'fixup-whitespace)
(global-set-key (kbd "C-C g")   'grep-find)
(global-set-key (kbd "C-C i")   'indent-region)
(global-set-key (kbd "C-C k")   'kill-region)
(global-set-key (kbd "C-C l")   'linum-mode)
(global-set-key (kbd "C-C o")   'find-file-at-point)
;;; (global-set-key (kbd "C-C p")   'compare-windows)
(global-set-key (kbd "C-C q")   'c-fill-paragraph)
(global-set-key (kbd "C-C r")   'revert-buffer)
(global-set-key (kbd "C-C s")   'sort-lines)
(global-set-key (kbd "C-C u")   'uncomment-region)
(global-set-key (kbd "C-C =")   'align-equal-signs-region)
(global-set-key (kbd "C-Z" )    'goto-line)
(global-set-key (kbd "C-c C-l") 'downcase-letter)
(global-set-key (kbd "C-c C-u") 'upcase-letter)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)


;---------------------------------------------------------------------
;  Set up JDE -- Java Development Environment
;---------------------------------------------------------------------
;;; (add-hook 'java-mode-hook
;;;           '(lambda ()
;;;              (make-local-variable 'write-contents-hooks)
;;;              (add-hook 'write-contents-hooks 'java-mode-untabify)))

(c-add-style "Java-Tom"
             '("Java"
               (c-basic-offset . 4)
               (c-offsets-alist
                (arglist-intro  . +)
                (arglist-close  . 0)
                (substatement-open . 0))))

;;;TODO:FIX (require 'java-mode-indent-annotations)
(add-hook 'java-mode-hook   'tomh-set-format)
(add-hook 'java-mode-hook   'ggtags-mode)
;;; (add-hook 'java-mode-hook   'smartscan-mode)

;;; (require 'meghanada)
;;; (add-hook 'java-mode-hook
;;;           (lambda ()
;;;             ;; meghanada-mode on
;;;             (meghanada-mode t)
;;;     ;;;        (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
;;;             )
;;;           )

;---------------------------------
;  java Imports handling
;---------------------------------
;;; (require 'java-imports)
;;; (define-key java-mode-map (kbd "C-c C-i") 'java-imports-add-import-dwim)
;;; (setq java-imports-find-block-function 'java-imports-find-place-sorted-block)
;;;
;;; (require 'eclim)
;;; (setq eclimd-autostart t)
;;; (global-eclim-mode)
;;; (require 'company)
;;; (global-company-mode t)
;;; (require 'company-emacs-eclim)
;;; (company-emacs-eclim-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(archive-zip-extract (quote ("unzip" "-p")))
 '(archive-zip-use-pkzip nil)
 '(auto-image-file-mode t)
 '(browse-url-netscape-program "firefox")
 '(case-fold-search t)
 '(clip-large-size-font t t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(display-time-mode t)
 '(eclim-eclipse-dirs (quote ("c:/Tools/eclipse/kepler")))
 '(eclim-executable "c:/Tools/eclipse/kepler/eclim.sh")
 '(ediff-diff-options "-wbB")
 '(eshell-debug-command t)
 '(font-list-limit 100)
 '(ibuffer-formats
   (quote
    ((mark modified read-only " "
           (name 30 30 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename))))
 '(jdee-jdk (quote ("1.7.0_75")))
 '(jdee-jdk-registry
   (quote
    (("1.7.0_75" . "/cygdrive/c/Tools/java/jdk1.7.0_75/"))))
 '(jdee-server-dir "/cygdrive/c/Tools/jdee-server/target/")
 '(js3-indent-level 4)
 '(lpr-command "lpr")
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(package-selected-packages
   (quote
    (dired-icon major-mode-icons mode-icons treemacs-icons-dired fontawesome octicons dash all-the-icons-dired centaur-tabs exwm doom-themes unicode-emoticons unicode-fonts doom-modeline golden-ratio lsp-css lsp-html lsp-intellij lsp-sh lsp-typescript lsp-ui ubuntu-theme gruvbox-theme lush-theme lsp-java lsp-mode eshell-git-prompt 0blayout egg eshell-prompt-extras boron-theme bitbucket zpresent tide sass-mode prettier-js magit magit-filenotify magit-find-file magit-gh-pulls magit-imerge magithub treemacs nav markdown-preview-eww markdown-preview-mode markdown-toc editorconfig typescript-mode flymd markdown-mode markdown-mode+ xah-css-mode web-beautify helm-ag json-mode ack-menu full-ack ggtags groovy-mode expand-region restclient multiple-cursors auto-complete elpy vc-check-status ibuffer-vc js3-mode solarized-theme beacon)))
 '(ps-landscape-mode t)
 '(ps-n-up-printing 2)
 '(ps-printer-name "10.2.4.74")
 '(revert-without-query (quote (".*")))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.cac.com")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t)
 '(user-full-name "Tom Halliley")
 '(user-mail-address "jhalliley@creditacceptance.com"))

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
;;; (autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
;;; (add-to-list 'auto-mode-alist '("\.groovy$"         . groovy-mode))
;;; (add-to-list 'auto-mode-alist '("\.gant$"           . groovy-mode))
;;; (add-to-list 'auto-mode-alist '("\.gradle"          . groovy-mode))
;;; (add-to-list 'auto-mode-alist '("gradlefile"        . groovy-mode))
;;; (add-to-list 'auto-mode-alist '("gradlesettings"    . groovy-mode))
;;; (add-to-list 'auto-mode-alist '("gradle.properties" . groovy-mode))

;;; (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;--------------------------------------------
;  Emacs Server (works with emacsclient)...
;--------------------------------------------
(server-start)


;--------------------------------------------
;  Recent file handling
;--------------------------------------------
(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

                                        ; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;--------------------------------------------
;  Pseudo JSP mode
;--------------------------------------------
;;; (require 'multi-mode)
;;;
;;; (defun jsp-mode () (interactive)
;;;   (multi-mode 1
;;;               'html-mode
;;;               '("<%--"     indented-text-mode)
;;;               '("<%@"      indented-text-mode)
;;;               '("<%="      html-mode)
;;;               '("<%"       java-mode)
;;;               '("%>"       html-mode)
;;;               '("<script"  java-mode)
;;;               '("</script" html-mode)
;;;               ))
;;;
;;; (setq auto-mode-alist (append '(("\\.jsp$" . jsp-mode))     auto-mode-alist))
(setq auto-mode-alist (append '(("\\.jar$" . archive-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.aar$" . archive-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.war$" . archive-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.ear$" . archive-mode)) auto-mode-alist))

;-------------------------------------------------------
;  Provides CSS editing mode
;-------------------------------------------------------
;;; FIX THIS (autoload 'css-mode "css-mode")
;;; (setq auto-mode-alist
;;;       (cons '("\\.css\\'" . css-mode) auto-mode-alist))
;;; (require 'sass-mode)

;-------------------------------------------------------
;  Provides PL/SQL editing mode
;-------------------------------------------------------
(autoload 'pls-mode  "pls-mode" "PL/SQL Editing Mode" t)
(setq auto-mode-alist (append '(("\\.sql$"  . pls-mode)) auto-mode-alist))
(setq pls-mode-hook '(lambda () (font-lock-mode 1)))

(require 'plsql)
(setq auto-mode-alist (append '(("\\.sql$"  . plsql-mode)) auto-mode-alist))

;-------------------------------------------------------
;  XML set up
;-------------------------------------------------------
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsd\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
;;; (rng-set-vacuous-schema)

;-------------------------------------------------------
; XSL mode & debugger
;-------------------------------------------------------
;;; (add-to-list 'load-path (concat (getenv "SITELISP_HOME") "/xslide"))
;;; (add-to-list 'load-path (concat (getenv "SITELISP_HOME") "/xslt-process-2.2/lisp"))
;;; (autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
;;; (add-hook 'xsl-mode-hook 'turn-on-font-lock)
;;;
;;; (setq auto-mode-alist
;;;       (append
;;;        (list '("\\.xsl" . xsl-mode))
;;;        auto-mode-alist))
;;;
;;; (require 'xslt-process)
;;; (require 'xslt-speedbar)

;;; (autoload 'xslt-process-mode "xslt-process" "Emacs XSLT processing" t)
;;; (autoload 'xslt-process-install-docbook "xslt-process"
;;;    "Register the DocBook package with XSLT-process" t)
;;; (add-hook 'sgml-mode-hook 'xslt-process-mode)
;;; (add-hook 'xml-mode-hook 'xslt-process-mode)
;;; (add-hook 'xsl-mode-hook 'xslt-process-mode)

(defadvice xml-mode (after run-xml-mode-hooks act)
  "Invoke `xml-mode-hook' hooks in the XML mode."
  (run-hooks 'xml-mode-hook))

;--------------------------------------------
; Line Numbering mode...
;--------------------------------------------
(require 'linum)

;--------------------------------------------
; Matching on everything...
;    buffer names, files names, etc.
;--------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-show-dot-for-dired t)
(ido-mode t)

;--------------------------------------------
; Emacs customizations...
;--------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-noticeable-prompt ((((class color) (min-colors 88) (background light)) (:background "DarkOrchid4" :foreground "white"))))
 '(smerge-base ((t (:background "wheat"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "medium spring green")))))


(pop-to-buffer "*shell*")
(require 'golden-ratio)
(golden-ratio-mode)
