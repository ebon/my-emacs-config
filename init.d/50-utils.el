;; * exec-pathの優先順位を設定 [2012-03-22 Thu 07:43]
;; http://sakito.jp/emacs/emacsshell.html#path
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/opt/local/bin"
              "/usr/local/bin"
              ))
  ;; PATH と exec-path に同じ物を追加します
  (when ;; (and
         (file-exists-p dir) ;; (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

;; * w3m
;; [[http://d.hatena.ne.jp/a_bicky/20120226/1330265529#20120226f3][Emacsにevernote-modeをインストールしてEvernoteを編集してみた - あらびき日記]]
(add-to-list 'load-path "/Applications/Emacs.app/Contents/share/emacs/site-lisp/w3m/")
(require 'w3m-load nil t)

;;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; eijiro
;; ref: [[http://d.hatena.ne.jp/zqwell-ss/20091205/1260037903][emacsで英辞郎を使う sdicでらくらく検索 - Secondary Storage]]
;;(setq load-path (cons "/usr/local/share/emacs/site-lisp" load-path)) ;; sdicのインストール先を特に指定していない場合
(setq load-path (cons "/Applications/Emacs.app/Contents/Resources/site-lisp/" load-path))
(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

(setq sdic-eiwa-dictionary-list
      '((sdicf-client "~/Dropbox/dict/eiji118.sdic")))
(setq sdic-waei-dictionary-list
      '((sdicf-client "~/Dropbox/dict/waei118.sdic")))
(setq sdic-default-coding-system 'utf-8-unix)