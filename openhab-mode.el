;;; openhab-mode.el --- Support openHAB files -*- lexical-binding: t; -*-

;; Copyright (C) 2021, by Peter Hoeg
;;
;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com
;; SPDX-License-Identifier: GPL-3.0-or-later
;; Package-Requires: ((emacs "27.1"))

;; This file is not part of GNU Emacs.

;;; Commentary:
;;
;; Support for openHAB files.

;;; Code:

(require 'imenu)
(require 'rx)

;;;###autoload
(define-derived-mode openhab-mode prog-mode "openHAB base mode"
  "Base mode for openHAB files."

  (setq-local comment-start "//"
              comment-end ""
              imenu-sort-function #'imenu--sort-by-name))

;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".items" eos) . openhab-item-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".persist" eos) . openhab-persistence-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".rules" eos) . openhab-rule-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".sitemap" (optional "s") eos) . openhab-sitemap-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".things" eos) . openhab-thing-mode))

(provide 'openhab-mode)

;;; openhab-mode.el ends here
