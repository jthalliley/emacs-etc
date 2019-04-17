;;  Borrowed from:

;;; $Id: maxframe.el 367 2007-03-29 19:46:23Z ryan $
;; maximize the emacs frame based on display size

;; Copyright (C) 2007 Ryan McGeary
;; Version: 0.1  Author: Ryan McGeary
;; Keywords: display frame window maximize

;; This code is free; you can redistribute it and/or modify it under the
;; terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.

;;----------------------------------------------------------------------------------------
;; -- JTH --
;;    Added:
;;       monitor-display-x-zero
;;       monitor-display-y-zero
;;       monitor-resize-current-frame
;;----------------------------------------------------------------------------------------


(defvar monitor-display-x-zero 0
  "x-coordinate of upper-left corner of screen."
  )

(defvar monitor-display-y-zero 0
  "y-coordinate of upper-left corner of screen."
  )

(defvar monitor-display-padding-width 5
  "Any extra display padding that you want to account for while
determining the maximize number of columns to fit on a display."
  )

;; The default accounts for a Mac OS X display with a menubar
;; height of 22 pixels, a titlebar of 23 pixels, and no dock.
;;    (defcustom monitor-display-padding-height (+ 22 23)
;; or for Windoze with WindowBlinds, this seems to work:
;;    (defvar monitor-display-padding-height 40
(defvar monitor-display-padding-height 40
  "Any extra display padding that you want to account for while
determining the maximize number of rows to fit on a display."
  )

(defun monitor-max-columns (width)
  "Calculates the maximum number of columns that can fit in pixels specified by WIDTH."
  (let ((scroll-bar (or (frame-parameter nil 'scroll-bar-width) 0))
        (left-fringe (or left-fringe-width (nth 0 (window-fringes)) 0))
        (right-fringe (or right-fringe-width (nth 1 (window-fringes)) 0)))
    (/ (- width scroll-bar left-fringe right-fringe
          monitor-display-padding-width)
       (frame-char-width))))

(defun monitor-max-rows (height)
  "Calculates the maximum number of rows that can fit in pixels specified by HEIGHT."
  (/ (- height monitor-display-padding-height)
     (frame-char-height)))

(defun monitor-set-frame-pixel-size (frame width height)
  "Sets size of FRAME to WIDTH by HEIGHT, measured in pixels."
  (set-frame-size frame (monitor-max-columns width) (monitor-max-rows height)))

(defun monitor-resize-current-frame (frame-width-offset frame-height-offset frame-x-offset frame-y-offset)
  "Resizes the current frame."
  (interactive)
  (setq monitor-width  (display-pixel-width))
  (setq monitor-height (display-pixel-height))

  (monitor-set-frame-pixel-size (selected-frame)
                                (- monitor-width  frame-width-offset)
                                (- monitor-height frame-height-offset)
                                )

  (set-frame-position (selected-frame)
                      (+ monitor-display-x-zero frame-x-offset)
                      (+ monitor-display-y-zero frame-y-offset)
                      )
  )


;;;----------------------------------------------------------------------------------------
;;; JTH added
;;;----------------------------------------------------------------------------------------

;=======================================================
; Downcase a letter
;=======================================================
(defun downcase-letter (n)
  (interactive "p")
  (while (> n 0)
    (let ((letter (downcase (char-after))))
      (delete-char 1)
      (insert letter)
      (setq n (1- n)))))

;=======================================================
;  Upcase a letter
;=======================================================
(defun upcase-letter (n)
  (interactive "p")
  (while (> n 0)
    (let ((letter (upcase (char-after))))
      (delete-char 1)
      (insert letter)
      (setq n (1- n)))))

(defun align-equal-signs-region()
  (align-regexp (point) (mark) "=")
)


;---------------------------------------------------------------------
;  Programming Language manipulations
;---------------------------------------------------------------------
(defun replace-regexp-region (regexp to-string)
  (interactive "sReplace (regexp): \nswith: ")
  (save-excursion
    (save-restriction
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (replace-regexp regexp to-string)))
)

(defun c-indent-function (beg end)
  (interactive "*r")
  (save-excursion
    ;;;  Should really calculcate where region should be...
    ;;;  that is, between function begin and end.
    (save-restriction
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (while (< (point) (point-max))
    (c-indent-command)
    (forward-line 1))))
)

(defun comment-region (delimiter)
  "Comment out region with specified delimiter"
  (interactive "sDelimiter: ")
  (replace-regexp-region "^" delimiter)
)

(defun uncomment-region (delimiter)
  "Uncomment region with specified delimiter"
  (interactive "sDelimiter: ")
  (replace-regexp-region (concat "^" delimiter) "")
)

(defun java-mode-untabify ()
  (untabify (point-min) (point-max))
  )
;;;(defun java-mode-untabify ()
;;;  (save-excursion
;;;    (goto-char (point-min))
;;;    (while (re-search-forward "[ \t]+$" nil t)
;;;      (delete-region (match-beginning 0) (match-end 0)))
;;;    (goto-char (point-min))
;;;    (if (search-forward "\t" nil t)
;;;        (untabify (1- (point)) (point-max)))
;;;    )
;;;  nil
;;;  )

(defun tomh-set-format()
  (c-set-style "Java-Tom")
  (set-fill-column 120)
  (java-mode-indent-annotations-setup)
)


(defun maximize-frame ()
  "Maximizes the active frame in Windows"
  (interactive)
  ;; Send a `WM_SYSCOMMAND' message to the active frame with the
  ;; `SC_MAXIMIZE' parameter.
  (when (eq system-type 'windows-nt)
    (w32-send-sys-command 61488)))
