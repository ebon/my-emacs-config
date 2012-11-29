;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; Contents:
;;  to manamge the way of installing an elisps

;;; Commentary:

;; ----------------------
;; @ install-elisp
;; refe: http://d.hatena.ne.jp/tomoya/20090121/1232536106#c1232583933
;; ----------------------
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; ----------------------
;; @ package
;; ----------------------
;; [[http://yag-ays.hateblo.jp/entry/2012/01/09/224531][Clojure + Emacs環境のセッティング（MacOSX Lion 10.7） - やぐブロ]]
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))
(package-initialize)