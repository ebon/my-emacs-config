;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; nw-emacs-config.el --- for no windows system :emacs23 init setting elisp file
;;; Commentary:

;; Emacs 23 nextstep port 用の設定
;; 個人的に重要な物を上になるべく配置

;;; Code:

;;-------------------------------------------------------
;;ベースとなるColorの設定
;;M-x list-colors-display　でリストが出せる
;;--------------------------------------------------------
;(global-font-lock-mode t)
(require 'font-lock)

(load "~/.emacs.d/elisp/my-color-theme")
(my-color-theme)

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))


;;; nw-emacs-config.el ends here