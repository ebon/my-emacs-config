;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; 01-buffer.el --- emacs23 init setting elisp file
;;; Contents  : バッファリスト、バッファ切り替え操作
;;; Commentary:

;;; -------------------------------------
;;; @ buffer
;;; -------------------------------------
;; バッファの切換えをもっと楽にしたい － iswitchb 
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=iswitchb
(iswitchb-mode 1)
(setq iswitchb-regexp t)
(add-hook 'iswitchb-define-mode-map-hook
      (lambda ()
        (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
        (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; iswitchb で選択中の内容を表示
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=iswitchb-exhibit
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;; replace default bufferlist to bs-show
(global-set-key "\C-x\C-b" 'bs-show) 

;; C-,, C-.でバッファをどんどん 切り替え
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=my-bury-buffer
(setq my-ignore-buffer-list
      '("*Help*" "*Compile-Log*" "*Mew completions*" "*Completions*"
        "*Shell Command Output*" "*Apropos*" "*Buffer List*"))

(defun my-visible-buffer (blst)
  (let ((bufn (buffer-name (car blst))))
    (if (or (= (aref bufn 0) ? ) (member bufn my-ignore-buffer-list))
        (my-visible-buffer (cdr blst)) (car blst))))

(defun my-grub-buffer ()
  (interactive)
  (switch-to-buffer (my-visible-buffer (reverse (buffer-list)))))

(defun my-bury-buffer ()
  (interactive)
  (bury-buffer)
  (switch-to-buffer (my-visible-buffer (buffer-list))))

(global-set-key [?\C-,] 'my-grub-buffer)
(global-set-key [?\C-.] 'my-bury-buffer)
(global-set-key [?\C-2] 'my-grub-buffer)
(global-set-key [?\C-1] 'my-bury-buffer)

;; ------------------------------------------------------------------------
;; @ other

;; バッファ画面外文字の切り詰め表示
(setq truncate-lines nil)

;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
(setq truncate-partial-width-windows t)

 ;; 同一バッファ名にディレクトリ付与
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; ------------------------------------------------------------------------
;; @ buffer history

;; recentf.el 最近使ったファイルを開く
;; ref:「Emacsテクニックバイブル」 p.87
;;
;; 最近のファイルを保存する
(setq recentf-max-saved-items 1000)
;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)

;; ------------------------------------------------------------------------
;; @ uniquify
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; * で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; ------------------------------------------------------------------------
;; * パスを1階層ずつ削除

;; minibufferでC-wで前の単語を削除
;; (define-key minibuffer-local-completion-map (kbd "C-w") 'backward-kill-word)
(defun my-minibuffer-delete-parent-directory ()
  "Delete one level of file path."
  (interactive)
  (let ((current-pt (point)))
    (when (re-search-backward "/[^/]+/?" nil t)
      (forward-char 1)
      (delete-region (point) current-pt))))
(define-key minibuffer-local-map (kbd "C-w") 'my-minibuffer-delete-parent-directory)

;;; 01-buffer.el ends here