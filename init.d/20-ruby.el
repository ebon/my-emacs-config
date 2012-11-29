;;; 20-ruby.el

;;; Commentary:

;; ruby-mode 用の設定
;; 以下等を参考にしつつ設定
;; http://d.hatena.ne.jp/yuko1658/20071213/1197517201
;; http://blog.livedoor.jp/k1LoW/archives/65214091.html
;; http://d.hatena.ne.jp/hiro_nemu/20090519/1242743910
;; http://d.hatena.ne.jp/eiel/20101106#1289059080

;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; rubydb
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; rcodetools
(require 'rcodetools)
(require 'anything-rcodetools)
(define-key ruby-mode-map "\C-cl" 'rct-complete-symbol)
(define-key ruby-mode-map "\C-cx" 'xmpfilter)

(provide 'init_ruby)
;;; init_ruby.el ends here