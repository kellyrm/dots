                                        ; ======== PACKAGES =========
                                        ; package path
(let ((default-directory "~/.emacs.d/pkg/"))
  (normal-top-level-add-to-load-path '("evil" "flx" "corfu" "corfu-terminal")))

                                        ; evil
(require 'evil)
(evil-mode 1)

(setq evil-search-wrap nil
      evil-regex-search t)

(evil-define-key 'motion 'global
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
  "-" nil
  "-c" 'make-default
  "-o" 'other-window
  "--" 'kill-secondary-window
  "-e" 'next-error
  "-a" 'previous-error
  "-p" 'switch-to-buffer
  "-y" 'find-file
  "-q" 'kill-buffer
  "-i" 'indent-region
  "-f" 'ido-find-tag
  "-l" 'load-tags
  "-h" 'pop-tag-mark
  "-g" 'find-tag
  "-t" 'corfu-complete)


(evil-define-key 'normal 'global
  "s" nil
  "S" nil)


                                        ; look
(setq display-line-numbers-type 'relative
      frame-background-mode 'dark)

                                        ; follow version symlinks to version control
(setq vc-follow-symlinks t)

                                        ; remove extra bars
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

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
 tab-width 4)

(standard-display-ascii ?\t "^...")
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)))

                                        ; compile
(defun find-upward (file dir)
  (if (file-exists-p (concat dir file))
      (expand-file-name dir)
    (if (string= (expand-file-name dir) "/")
        nil
      (find-upward file (concat dir "../")))))

(defun load-tags ()
  (interactive)
  (visit-tags-table (find-upward "TAGS" "./"))
  (tags-completion-table)
  (let (_tag-names)
    (mapcar (lambda (x)
              (push (prin1-to-string x t) _tag-names))
            tags-completion-table)
    (setq tag-names _tag-names)))

(setq c-mode-hook
      '(lambda ()
         (load-tags)))
  
(defun make-default ()
  (interactive)
  (when-let (path (find-upward "Makefile" "./"))
    (compile (format "SILENT=1 make -C %s" path))
    (load-tags)))

(defun kill-secondary-window ()
  (interactive)
  (dolist (name (list "*compilation*" "*Help*"))
    (when-let
        ((buf (get-buffer name))
         (win (get-buffer-window buf)))
      (when (select-window win)
        (quit-window)))))

(defun kill-secondary-buffer ()
  (interactive)
  (act-secondary-buffer 'select-window))

                                        ; ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq gc-cons-threshold 20000000)

(defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (find-tag (ido-completing-read "Tag: " tag-names)))

                                        ; corfu
(require 'corfu)
(require 'corfu-terminal)

(global-corfu-mode)
(corfu-terminal-mode +1)

