;;; 22-python.el

;;; Commentary:

;; python用の設定
;; 以下等を参考にしつつ設定
;; http://weblog.nekonya.com/2010/11/cocoa-emacs-python.html
;; http://sheephead.homelinux.org/2009/09/29/1614/
;; http://d.hatena.ne.jp/shiba1029196473/20100403/1270310658


;; 実行後、カーソルのフォーカスが*Help*や*Python Output*バッファに移動しない
;; [[http://d.hatena.ne.jp/y_yanbe/20060629/1151589858][python-mode on emacs 環境向上計画 - yanbe.log]]

;;; python-mode
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode)
;;        interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (define-key python-mode-map "\"" 'electric-pair)
;;             (define-key python-mode-map "\'" 'electric-pair)
;;             (define-key python-mode-map "(" 'electric-pair)
;;             (define-key python-mode-map "[" 'electric-pair)
;;             (define-key python-mode-map "{" 'electric-pair)))

;; (setq ipython-command "/usr/local/share/python/ipython")
;; (setq py-python-command-args '( "--colors" "Linux"))
;; (require 'ipython)


;;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path "~/.emacs.d/Pymacs"))


;;; rst-mode
;; -- mode for sphinx --
(require 'rst)
(autoload 'rst-mode "rst-mode" "mode for editing reStructuredText documents" t)
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

;; ipython, org-babel
;; [[http://eschulte.me/emacs24-starter-kit/starter-kit-python.html][Starter Kit Python]]
;; (setq py-python-command-args '("--colors=linux"))
;; (setq ipython-command "/usr/local/share/python/ipython")
;; (setq py-default-interpreter "ipython")
;; (require 'ipython)

;; lambda-mode
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
