;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; cocoa-emacs-config.el --- emacs23 init setting elisp file
;;; Commentary:
;;; Emacs 23 mac 用の設定

;;; Code:
;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote control))

;;;-------------------
;;; frame:
;;;-------------------
(setq default-frame-alist
      (append
       (list
        '(foreground-color . "white")
        '(background-color . "black")
        '(top . 22)
        '(left . 50)
        '(width . 170)
        '(height . 70)
        '(line-spacing . 1)
        '(cursor-color . "gray")
        )
       default-frame-alist))

;;;-------------------
;;; font:
;;;-------------------
(when (>= emacs-major-version 23)
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 115)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("Hiragino Mincho Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("Hiragino Mincho Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.0)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3))))

;;(add-to-list 'default-frame-alist '(font . "fontset-septemberipagothic"))  ;; 実際に設定する場合

;; dndの動作を Emacs22と同じにする
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)


;;; cocoa-emacs-config.el ends here