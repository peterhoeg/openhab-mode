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
;; (require 'openhab-rule-mode)
(require 'openhab-thing-mode)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.items\\'" . openhab-item-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.rules\\'" . openhab-rule-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.things\\'" . openhab-thing-mode))

;; :mode ("\\.\\(items\\|persist\\|sitemap\\|things\\)\\'" . java-mode)

(provide 'openhab-mode)

;;; openhab-mode.el ends here