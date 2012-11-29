;; ----------------------
;; @ cursol
;; ----------------------
(blink-cursor-mode 0)              ;; 点滅する

;;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)


;;; マウスカーソルを編集中に消す
;; n0=消さない それ以外=消えるまでの時間 (ミリ秒)
(setq w32-hide-mouse-timeout 1000)
;; nil=消さない t=キー入力でマウスカーソルが消える
(setq w32-hide-mouse-on-key t)


;;; previous-line等がバインドされたキーを押し続けることで、移動量が加速していく
(require 'accelerate)

(accelerate previous-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
(accelerate next-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
(accelerate smooth-scroll-down '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
(accelerate smooth-scroll-up '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
(accelerate dired-previous-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
(accelerate dired-next-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))

;; ----------------------
;; @ scroll
;; ----------------------

;; カーソル動かさずにスクロール
(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))
(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))
;; (global-set-key "\M-p" 'scroll-up-in-place)
;; (global-set-key "\M-n" 'scroll-down-in-place)


;; ----------------------
;; @ cursol position
;; ----------------------
;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
(setq set-mark-command-repeat-pop t)

;; ----------------------
;; @ cursol undo
;; ----------------------
(require 'point-undo)
(require 'goto-chg)                     ; go to last change