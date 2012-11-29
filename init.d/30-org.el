;;; 30-org.el --- config for org-mode

;;; Commentary:

;; org-mode 用の設定
;; yasnippet http://github.com/RickMoynihan/yasnippet-org-mode

;;; Code

;; ---------------------
;; org-mode
;; ---------------------
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; keymap
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cc" 'org-remember-code-reading)
;(define-key global-map "\C-cr" 'org-capture) ; captureは挙動の不満を解消できていないため見送り

;; basic
(setq org-startup-truncated nil)        ; 改行する
(setq org-hide-leading-stars t)         ; 余分な*を隠す

;; default org-directory
(cond
 (ns-p
  (setq org-directory "~/Dropbox/org/")))

;; org-files
(setq org-default-notes-file (concat org-directory "notes.org"))

;; call org-files
(defun note () (interactive) (find-file org-default-notes-file))
(defun gtd  () (interactive) (find-file (concat org-directory "my.org")))
(defun pri  () (interactive) (find-file (concat org-directory "pri.org")))
(defun eng  () (interactive) (find-file (concat org-directory "english-grammer.org")))

;; Task status
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SDAY(s)" "PEND(p)")))

;; DONEの時刻を記録
(setq org-log-done 'time)

;; agendaの探索対象ファイル
(setq org-agenda-files (list (concat org-directory "pri.org")
                             (concat org-directory "habits.org")))


;; org-capture-templates
(org-remember-insinuate)
 (setq org-remember-templates
     '(("Todo" ?t "* TODO %? %^g\n %i\n Added:%U" "my.org" "Inbox")
       ("PriTodo" ?p "* TODO %? %^g\n %i\n Added:%U" "pri.org" "Inbox")
       ("Memo" ?m "* %^{topic} %U \n%i%?\n" nil )
       ("Book" ?b "* %^{Book Title} %U :book:unread: \n%[~/Dropbox/org/tmpl_book.txt]\n" nil)
       ("Blog" ?j "* %^{topic} %u :blog: \n%[~/Dropbox/org/tmpl_blog.txt]\n" "blog.org")
       ("Rational-emotive therapy" ?r "* %^{topic} %U :ret: \n%[~/Dropbox/org/tmpl_rational-emotive-therapy.txt]\n")
      ))

;;; org-remember-code-reading
(defvar org-code-reading-software-name nil)
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%? %U\n  %a\n"
             ,org-code-reading-file "Memo"))))
    (org-remember)))

;; 習慣(habits)の記録 mode
;; http://orgmode.org/worg/org-tutorials/tracking-habits.html
(require 'org-habit)

;; hideshow-org.el
;; https://github.com/secelis/hideshow-org
(require 'hideshow-org)
(global-set-key "\C-ch" 'hs-org/minor-mode)


;; With octopress
;; [[http://jaderholm.com/blog/blog/2011/09/26/blogging-with-org-mode-and-octopress/][Blogging With Org-mode and Octopress - Programothesis]]
(setq org-publish-project-alist
      '(("blog" .  (:base-directory "~/Dropbox/git/octopress/source/org_posts/"
                                    :base-extension "org"
                                    :publishing-directory "~/Dropbox/git/octopress/source/_posts/"
                                    :sub-superscript ""
                                    :recursive t
                                    :publishing-function org-publish-org-to-html
                                    :headline-levels 4
                                    :html-extension "markdown"
                                    :body-only t))
        ("page" .  (:base-directory "./"
                                    :base-extension "org"
                                    :publishing-directory "./"
                                    :sub-superscript ""
                                    :recursive t
                                    :publishing-function org-publish-org-to-html
                                    :headline-levels 4
                                    :html-extension "markdown"
                                    :body-only t))))

;; org-babel
;; ref [[http://eschulte.me/emacs-starter-kit/starter-kit-org.html][Starter Kit Org]]
(setq org-use-speed-commands t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (R . t)
   (perl . t)
   (ruby . t)
   (python . t)
   (js . t)
   (haskell . t)
   (clojure . t)
   (ditaa . t)))
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;;; 30-org.el ends here
