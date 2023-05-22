;;; openhab-mode.el --- base mode for various openhab modes

;; Copyright © 2021, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;;; License:
;;
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:
;;
;; Base mode for various openHAB modes in Emacs

;;; Code:

(defvar openhab-mode-hook nil)

(require 'openhab-item-mode)
(require 'openhab-persistence-mode)
(require 'openhab-rule-mode)
(require 'openhab-sitemap-mode)
(require 'openhab-thing-mode)

;;;###autoload
(define-derived-mode openhab-mode prog-mode "openHAB base mode"
  "Base mode for openHAB files."

  (setq-local comment-start "//"
              comment-end ""
              imenu-sort-function #'imenu--sort-by-name))

;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".items" eos) . openhab-item-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".persistence" eos) . openhab-persistence-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".rules" eos) . openhab-rule-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".sitemap" (optional "s") eos) . openhab-sitemap-mode))
;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".things" eos) . openhab-thing-mode))

;; :mode ("\\.\\(items\\|persist\\|sitemap\\|things\\)\\'" . java-mode)

(provide 'openhab-mode)

;;; openhab-mode.el ends here
