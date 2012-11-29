;; ------------------------------------------------------------------------
;; @ 初期フレームの設定

;; フレームタイトルの設定
(setq frame-title-format "%b")

; ------------------------------------------------------------------------
;; @ window/frame operation

;; 分割した画面を入れ替える
;; http://www.bookshelf.jp/soft/meadow_30.html#SEC403
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))

(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)

; ------------------------------------------------------------------------
;; @ windows.el

;; キーバインドを変更．
;; デフォルトは C-c C-w
;; 変更しない場合」は，以下の 3 行を削除する
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
(setq win:base-key ?`) ;; ` は「直前の状態」
(setq win:max-configs 27) ;; ` ～ z は 27 文字
(setq win:quick-selection nil) ;; C-c 英字 に割り当てない

(require 'windows)
(setq win:use-frame nil) ;; 新規にフレームを作らない
(win:startup-with-window)

;; C-x C-c で終了するとそのときのウィンドウの状態を保存する
;; C-x C なら保存しない
(define-key ctl-x-map "\C-c" 'see-you-again)
(define-key ctl-x-map "C" 'save-buffers-kill-emacs)

(run-with-idle-timer 3600 t 'save-current-configuration)

;; 保存したウィンドウを再現
(define-key global-map "\C-z\C-r" 'resume-windows)

;; 分割したウィンドウ間を Shift + 矢印キー で移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; [[http://d.hatena.ne.jp/mooz/20100119/p1"][分割したウィンドウの大きさをインタラクティヴに変更する - mooz deceives you]]
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

(global-set-key "\C-c\C-r" 'window-resizer)


;; ------------------------------------------------------------------------
;; @ hiwin-mode
(require 'hiwin)
(setq hiwin-deactive-color "gray30") ;; 非アクティブwindowの背景色（hiwin-modeの実行前に設定が必要）
(hiwin-mode) ;; hiwin-modeを有効にする

;;; -----------------------------------------------------------------------
;; 反対側のウィンドウにいけるように
(setq windmove-wrap-around t)
;; C-M-{h,j,k,l}でウィンドウ間を移動
(define-key global-map (kbd "C-M-h") 'windmove-left)
(define-key global-map (kbd "C-M-l") 'windmove-right)
(define-key global-map (kbd "C-M-k") 'windmove-up)
(define-key global-map (kbd "C-M-j") 'windmove-down)

;;; window-number
(require 'window-number)
(window-number-mode nil)
(window-number-meta-mode 1)