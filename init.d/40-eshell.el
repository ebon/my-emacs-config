;; Eshell
;; [[http://d.hatena.ne.jp/a666666/20110222/1298345699][おれの eshell の設定 - 刺身☆ブーメランのはてなダイアリー]]

;; 実行パスの追加
(add-to-list 'exec-path "/usr/local/bin")
;; eshell 用のものを追加
(setq eshell-path-env (concat "/usr/local/bin:" (getenv "PATH")))

;; Emacs 起動時に Eshell を起動
;(add-hook 'after-init-hook (lambda () (eshell) ))
(setq eshell-cmpl-ignore-case t)                 ;; 補完時に大文字小文字を区別しない
(setq eshell-ask-to-save-history (quote always)) ;; 確認なしでヒストリ保存
(setq eshell-history-file-name "~/.zsh-history") ;; zsh のヒストリと共有
(setq eshell-history-size 100000)				 ;; ヒストリサイズ
(setq eshell-hist-ignoredups t) 		         ;; ヒストリの重複を無視

;; 補完時にサイクルする
;(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
;(setq eshell-cmpl-cycle-cutoff-length 5)
;; prompt 文字列の変更
(setq eshell-prompt-function
      (lambda ()
        (concat "[noean@mba: "
                (eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]\n$ ")
                )))
;; 変更した prompt 文字列に合う形で prompt の初まりを指定 (C-a で"$ "の次にカーソルがくるようにする)
;; これの設定を上手くしとかないとタブ補完も効かなくなるっぽい
(setq eshell-prompt-regexp "^[^#$]*[$#] ")
;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
;               (yas/minor-mode -1)      ; yasnippet マイナーモードだと eshell-cmpl-cycle-completions がバグるのでオフる。 C-u - M-x yas/minor-mode と等価。
               (define-key eshell-mode-map [up] 'previous-line)
               (define-key eshell-mode-map [down] 'next-line)
               ;(define-key eshell-mode-map [(meta return)] 'ns-toggle-fullscreen)
               (define-key eshell-mode-map [(meta return)] (select-toggle-fullscreen))
               )
             ))
;; (define-key global-map (kbd "C-z") 'eshell)
;; エスケープシーケンスを処理
;; http://d.hatena.ne.jp/hiboma/20061031/1162277851
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
;; http://www.emacswiki.org/emacs-ja/EshellColor
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)