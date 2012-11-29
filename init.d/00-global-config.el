;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; 00-global-config.el --- global(common) congifuration for all enviroment

;;; Commentary:
;; ----------------------
;; @ ubiquitous
;; ----------------------
;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session
(require 'cl)
(ffap-bindings)       ;; ref:「Emacsテクニックバイブル」 p.83
;(require 'ffap)
(require 'ansi-color)
;(require 'recentf)
;(require 'saveplace)

;; ----------------------
;; @ auto-install
;; refe: http://d.hatena.ne.jp/tomoya/20090423/1240456834
;; ----------------------
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; ----------------------
;; @ completion
;; ----------------------

;; auto-complete-mode
(require 'auto-complete)
(global-auto-complete-mode t)

;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; 部分一致の補完機能を使う; p-bでprint-bufferとか
(partial-completion-mode t)

;;動的略語展開で大文字小文字を区別
(setq dabbrev-case-fold-search nil)

;; ----------------------
;; @ history
;; ----------------------
(setq history-length 10000)        ;; 履歴数を大きくする
(savehist-mode 1)                  ;; ミニバッファの履歴を保存する


;; ----------------------
;; @ default
;; ----------------------
(cd "~/")                          ;; 初期位置
(menu-bar-mode nil)                ;; menubar
(tool-bar-mode 0)                  ;; toolbar
(setq visible-bell t)              ;; 音鳴らさない
(setq ring-bell-function '(lambda ())) ;何もおこらなくする
(setq inhibit-startup-message t)   ;; 起動時のmessageを表示しない
(setq initial-scratch-message nil) ;; scratch のメッセージを空にする

;; ファイルを編集した場合コピーにてバックアップする
;; inode 番号を変更しない
(setq backup-by-copying t)
;;; バックアップファイルの保存位置指定[2002/03/02]
;; !path!to!file-name~ で保存される　
(setq backup-directory-alist
      '(
        ("^/etc/" . "~/.emacs.d/var/etc")
        ("." . "~/.emacs.d/var/emacs")
        ))


;; ----------------------
;; @ 編集関連
;; ----------------------
;; モードラインにライン数、カラム数表示
(line-number-mode 1)
(column-number-mode 1)

;; リージョンを kill-ring に入れないで削除できるようにする
(delete-selection-mode t)

;; C-kで行全体を削除
(setq kill-whole-line t)

;; TAB はスペース 4 個ぶんを基本
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; 対応するカッコを色表示する
;; 特に色をつけなくてもC-M-p、C-M-n を利用すれば対応するカッコ等に移動できる
(show-paren-mode t)
(setq show-paren-style 'mixed)
;; 括弧の色を薄く
(defvar paren-face 'paren-face)
(make-face 'paren-face)
(set-face-foreground 'paren-face "#999999")

(dolist (mode '(lisp-mode
                emacs-lisp-mode
                scheme-mode
                clojure-mode))
  (font-lock-add-keywords mode
                          '(("(\\|)" . paren-face))))

;; 印刷の設定
(setq ps-multibyte-buffer 'non-latin-printer)

;; 自動改行関連
(setq-default auto-fill-mode nil)
(setq-default fill-column 300)
(setq text-mode-hook 'turn-off-auto-fill)

;; -------------------
;; @ Killing
;; -------------------

;; 範囲指定していないとき、C-wで前の単語を削除
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

;; C-kで行が連結したときにインデントを減らす
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

(defadvice kill-sexp (around kill-sexp-and-fixup activate)
  (if (and (not (bolp)) (eolp))
      (progn
        (forward-char)
        (fixup-whitespace)
        (backward-char)
        (kill-line))
      ad-do-it))


;; ----------------------
;; @ line
;; ----------------------
(setq next-line-add-newlines nil)  ;; 新規行を作成しない
(global-hl-line-mode)              ;; 現在行を目立たせる
(toggle-scroll-bar nil)            ;; unshow scroll bar


;; ----------------------
;; @ other
;; ----------------------
;; 終了時に聞く
(setq confirm-kill-emacs 'y-or-n-p)

;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; ダイアログを使わない
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; キーストロークのミニバッファへの表示を早く
(setq echo-keystrokes 0.1)

;; 安全な実行のための共通系関数
;; @see http://www.sodan.org/~knagano/emacs/dotemacs.html
(defmacro eval-safe (&rest body)
  "安全な評価。評価に失敗してもそこで止まらない。"
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))
(defun load-safe (loadlib)
  "安全な load。読み込みに失敗してもそこで止まらない。"
  ;; missing-ok で読んでみて、ダメならこっそり message でも出しておく
  (let ((load-status (load loadlib t)))
    (or load-status
        (message (format "[load-safe] failed %s" loadlib)))
    load-status))
(defun autoload-if-found (functions file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (if (not (listp functions))
      (setq functions (list functions)))
  (and (locate-library file)
       (progn
         (dolist (function functions)
           (autoload function file docstring interactive type))
         t )))


;; emacsclient を利用するためにサーバ起動
;; サーバが起動していた場合は先に起動していた方を優先
(require 'server)
(unless (server-running-p) (server-start))
(defun skt:raise-frame()
  ;; Frame を前面にする
  (raise-frame (selected-frame))
  ;; キーボードフォーカスを選択しているFrameにする
(x-focus-frame (selected-frame)))
(add-hook 'server-visit-hook 'skt:raise-frame)
(add-hook 'find-file-hook 'skt:raise-frame)

;;; ends here