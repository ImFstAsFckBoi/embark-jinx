
;;; embark-jinx.el --- Add Jinx context awareness to Embark    -*- lexical-binding:t -*-

;; Filename: embark-jinx.el
;; Description: Add jinx context awareness to Embark
;; Author: Martin Olivesten <mbao02@pm.me>
;; Copyright (C) 2025  Martin Olivesten, all rights reserved.
;; Created: 2025-03-18

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Simple package to make Embark aware of jinx spellchecker misspellings.
;; When installed, running embark-act (C-.) on a misspelled word should bring up the embark-jinx-map keymap.
;;
;;; Installation:
;;
;; (require 'embark-jinx)
;;
;; (use-package embark-jinx
;;   :after (embark jinx))


;;; Require
(require 'embark)
(require 'jinx)


;;; Code
(defun embark-jinx--get-jinx-overlay-at-point ()
  (car (jinx--get-overlays (- (point) 1) (+ (point) 1))))


(defun embark-jinx--target-jinx-at-point ()
  (let ((ov (embark-jinx--get-jinx-overlay-at-point)))
    (if (not ov) nil
      (let ((b (overlay-start ov)) (e (overlay-end ov)))
        `(jinx ,(buffer-substring-no-properties b e) ,b .  ,e)))))


(defun embark-jinx-correct (_)
  "Correct spelling using jinx"
  (call-interactively 'jinx-correct))


(defun embark-jinx-languages (_)
  "Set jinx's used language"
  (call-interactively 'jinx-languages))


(defvar-keymap embark-jinx-map
  :doc "Keymap for jinx marked words."
  "n" #'jinx-next
  "p" #'jinx-previous
  "l" #'embark-jinx-languages
  "RET" #'embark-jinx-correct)


(add-to-list 'embark-target-finders 'embark-jinx--target-jinx-at-point)
(add-to-list 'embark-keymap-alist '(jinx . embark-jinx-map))


(provide 'embark-jinx)
;;; embark-jinx.el ends here
