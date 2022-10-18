                                        ; ======== PACKAGES =========
                                        ; package path
(let ((default-directory "~/.emacs.d/pkg/"))
  (normal-top-level-add-to-load-path
   '(
     "evil"
     "flx"
     "corfu" "corfu-terminal" "popon"
     "gtags-mode"
     "orderless" "vertico"
     )))

                                        ; evil
(require 'evil)
(evil-mode 1)

(setq evil-search-wrap nil
      evil-regex-search t)

(evil-define-key 'motion 'global
                                        ; dvorak rebinds
  "h" 'evil-backward-char
  "t" 'evil-next-line
  "n" 'evil-previous-line
  "s" 'evil-forward-char
  "H" 'evil-first-non-blank
  "T" 'evil-scroll-page-down
  "N" 'evil-scroll-page-up
  "S" 'evil-end-of-line
  "k" 'evil-find-char-to
  "K" 'evil-find-char-to-backward
  "l" 'evil-search-next
  "L" 'evil-search-previous
                                        ; dash
  "-" nil
                                        ; dialogs
  "-f" 'gtags-find-tag
  "-p" 'switch-to-buffer
  "-x" 'execute-extended-command
  "-y" 'find-file
  "-Y" 'gtags-find-file

  "-a" 'gtags-pop-stack
  "-e" 'next-error
  "-g" 'gtags-find-tag-from-here
  "-u" 'previous-error

  "-b" 'project-build
  "-c" 'project-translate
  "-G" 'project-rebuild-tags
  "-r" 'project-rebuild
  "-v" 'select-target
  "-R" 'reload-config

  "-[" 'select-refs
  "-]" 'version-control
                                        ; editor commands
  "-i" 'indent-region
  "-k" 'kill-buffer
  "-/" 'comment-or-uncomment-region
                                        ; window commands
  "--" 'kill-secondary-window
  "-o" 'secondary-window
  "-t" 'open-term
                                        ; merge
  "-m" 'smerge-mode
  "-l" 'smerge-next
  "-L" 'smerge-previous
                                        ; space
  (kbd "<SPC>") nil
  (kbd "<SPC>u") 'add-window-lines
  (kbd "<SPC>d") 'remove-window-lines
  (kbd "<SPC>w") 'add-window-columns
  (kbd "<SPC>c") 'remove-window-columns
  (kbd "<SPC>h") 'evil-window-left
  (kbd "<SPC>t") 'evil-window-down
  (kbd "<SPC>n") 'evil-window-up
  (kbd "<SPC>s") 'evil-window-right
  (kbd "<SPC>q") 'delete-window
  (kbd "<SPC>Q") 'close-all-buffers
  (kbd "<SPC>v") 'evil-window-split
  (kbd "<SPC><RET>") 'evil-window-vsplit
  )


(evil-define-key 'normal 'global
  "s" nil
  "S" nil)

(setq minibuffer-message-timeout nil)

(defun reload-config ()
  (interactive)
  (load-file "~/.emacs"))

(defun close-all-buffers ()
  (interactive)
  (kill-matching-buffers "^[^\*].*[^\*]$" nil 'true)
  (delete-other-windows))

(defun set-window-height (window target)
    (window-resize window (- target (window-height window))))

(defun add-window-lines (arg)
  (interactive "p")
  (enlarge-window (* 10 arg)))

(defun remove-window-lines (arg)
  (interactive "p")
  (shrink-window (* 10 arg)))

(defun add-window-columns (arg)
  (interactive "p")
  (enlarge-window (* 20 arg) 't))

(defun remove-window-columns (arg)
  (interactive "p")
  (shrink-window (* 20 arg) 't))

(defun select-from-project-list (name allow-multiple next)
  (when-let ((get-command (get-project-shell (format "get-list_%s" name) '()))
             (options (split-string (shell-command-to-string get-command))))
    (let ((selected (list)))
      (while (progn
               (let ((entry (ido-completing-read
                             (format "Select %s: " name)
                             (push ";" options)
                             nil nil "" nil ";")))
                 (if (or
                      (not allow-multiple)
                      (string= entry ";"))
                     nil
                   (progn
                     (delete entry options)
                     (push entry selected))))))
      (funcall next selected))))

(defun do-project-command (cmd use-minibuffer args)
  (let ((shell-command 
         (get-project-shell cmd args)))
    (let ((result (shell-command-to-string shell-command))) 
      (when use-minibuffer
      (minibuffer-message result)))))

(defun modify-project-list (name allow-multiple use-minibuffer)
  (select-from-project-list
   name
   allow-multiple
   #'(lambda (selected)
      (do-project-command
         (format "set-list_%s" name)
         use-minibuffer
         (list (string-join selected ","))))))

(defun select-target ()
  (interactive)
  (modify-project-list "target" 'true nil))

(defun select-refs ()
  (interactive)
  (modify-project-list "refs" 'true 'true))

(defun version-control ()
  (interactive)
  (select-from-project-list
   "submodules"
   'true
   #'(lambda (result)
       (do-project-command
        "run-vcs"
        'true
        (list (string-join result ",")
        (read-from-minibuffer "VCS: " "status"))))))

(defun open-term (arg)
  (interactive "p")
  (let ((term-name (format "*term-%d*" arg))
        (return-buffer (current-buffer)))
    (unless (string= term-name (buffer-name return-buffer))
      (setq secondary-window-return (get-buffer-window return-buffer))
      (if-let ((cur-buffer (get-buffer term-name)))
          (switch-to-buffer-other-window cur-buffer)
        (let ((new-term (shell)))
          (switch-to-buffer new-term)
          (rename-buffer term-name))))))


                                        ; look
(setq display-line-numbers-type 'relative
      frame-background-mode 'dark)

;; (require 'centered-window-mode "centered-window")
;; (centered-window-mode t)
;; (setq cwm-centered-window-width 40)

;; (add-hook 'linum-before-numbering-hook
;;           #'(lambda ()
;;               (setq-local linum-format
;;                           (format "%%%dx" (display-line-numbers-width)))))

;; (setq linum-format "%5x")

                                        ; follow version symlinks to version control
(setq vc-follow-symlinks t
      make-backup-files nil
      auto-save-mode -1)

                                        ; remove extra bars
(menu-bar-mode -1)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

                                        ; linenum
(require 'display-line-numbers)
(defun display-line-numbers--turn-on ()
  (unless (or (minibufferp)
              (member major-mode (list '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode))))
    (display-line-numbers-mode 'relative)))
(global-display-line-numbers-mode)

                                        ;tabs
(setq-default
 indent-tabs-mode nil
 tab-always-indent 'complete
 tab-width 4)

(standard-display-ascii ?\t "^...")
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)))

                                        ; compile
(defun window-by-name (buf-name)
  (if-let
      ((buf (get-buffer buf-name))
       (win (get-buffer-window buf)))
      win
    nil))

(defun find-upward (file dir)
  (if (file-exists-p (concat dir file))
      (expand-file-name dir)
    (if (string= (expand-file-name dir) "/")
        nil
      (find-upward file (concat dir "../")))))

(defun get-project-shell (command args)
  (if-let ((project-root (find-upward "_project.sh" "./")))
      (format "project-shell %s %s %s" project-root command
              (string-join args " "))
    nil))

(defun project-shell-cmd (command)
  (interactive)
  (when-let ((project-shell (get-project-shell command (list (buffer-file-name)))))
    (compile project-shell)
    (set-window-height (window-by-name "*compilation*") 25)))

(defun project-translate ()
  (interactive)
  (project-shell-cmd "translate"))

(defun project-build ()
  (interactive)
  (project-shell-cmd "build"))

(defun project-rebuild ()
  (interactive)
  (project-shell-cmd "rebuild"))

(defun project-rebuild-tags()
  (interactive)
  (project-shell-cmd "rebuild-tags"))


(defun kill-secondary-window ()
  (interactive)
  (dolist (name (list "*compilation*" "*Help*" "*Warnings*"))
    (when-let
        ((buf (get-buffer name))
         (win (get-buffer-window buf)))
      (when (select-window win)
        (quit-window)))))

(defun secondary-window ()
  (interactive)
  (when-let
      ((secondary-names '("*compilation*" "*Help*" "*Warnings*"))
       (cur-buf (current-buffer))
       (cur-name (buffer-name cur-buf))
       (cur-win (get-buffer-window cur-buf)))
    (if (or
         (member cur-name secondary-names)
         (string-match "\*term-[0-9]\*" cur-name))
        (select-window secondary-window-return)
      (progn
        (setq secondary-window-return cur-win)
        (dolist (name secondary-names)
          (when-let
              ((buf (get-buffer name))
               (win (get-buffer-window buf)))
            (select-window win)))))))


                                        ; ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq gc-cons-threshold 5000000)
(setq ido-completion-buffer nil)

(require 'gtags)
(setq gtags-select-mode-hook
      '(lambda ()
         (setq hl-line-face 'bold)
         (hl-line-mode 1)
         (evil-define-key 'normal 'local (kbd "RET") 'gtags-select-tag)))

(require 'gtags-mode)
(gtags-mode 1)

                                        ; corfu
(require 'corfu)
(require 'corfu-terminal)
(require 'orderless)
(global-corfu-mode)
(corfu-terminal-mode +1)

(setq corfu-cycle t
      corfu-quit-at-boundary nil
      corfu-quit-no-match nil
      corfu-preview-current nil
      completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overries '((file (styles . (partial-ompletion)))))

(define-key corfu-map [remap corfu-complete] #'corfu-next)
(evil-define-key 'insert 'corfu-map (kbd "<escape>") #'(lambda ()
                                                         (interactive)
                                                         (evil-normal-state)
                                                         (corfu-quit)))

                                        ; vertico
(require 'vertico)
(vertico-mode)

                                        ; semantic
;; (require 'semantic)
;; (require 'semantic/db-ebrowse)
;; (semantic-mode 1)
;; (global-semanticdb-minor-mode)

;; (defun disable-undo-hook ()
;;   (interactive)
;;   (when (string= (buffer-name) "*semanticdb-ebrowse-tmp*")
;;     (buffer-disable-undo)
;;     (setq-local undo-disabled t)))

;; (define-minor-mode disable-undo
;;   "Checks to disable undo"
;;   :init-value t
;;   :after-hook disable-undo-hook)

;; (setq warning-suppress-types
;;       '((undo discard-info)))

;; (defun semantic-parse-project (&optional suffix)
;;   (interactive)
;;   (if-let (project (find-upward ".git" "./"))
;;       (semanticdb-project-database (concat project suffix))))

;; (defun semantic-parse-project-parent ()
;;   (interactive)
;;   (semantic-parse-project "../"))

