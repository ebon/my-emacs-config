;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; 07-scroll.el --- emacs23 init setting elisp file
;;; Contents  : scroll
;;; Commentary:

;; スクロールのマージン
;; 指定した数字行だけスクロール
(setq scroll-conservatively 10000)

;; scroll-conservatively の古いバージョン。一行ずつスクロールする
(setq scroll-step 1)

;; カーソル位置を変更しない
(setq scroll-preserve-screen-position t)

;; shell-mode において最後の行ができるだけウィンドウの一番下にくるようにする
(setq comint-scroll-show-maximum-output t)

;; C-v や M-v した時に以前の画面にあった文字を何行分残すか(初期設定 2)
;;(setq next-screen-context-lines 5)

;; 上端、下端における余白幅(初期設定 0)
;; (setq scroll-margin 10)

;;; Scroll default 1P to harlP
(define-key global-map (kbd "C-v")
  '(lambda () (interactive) (scroll-up (/ (window-height) 2))))
(define-key global-map (kbd "M-v")
  '(lambda () (interactive) (scroll-down (/ (window-height) 2))))

;;; smooth-scrol
(require 'smooth-scroll)
(smooth-scroll-mode t)