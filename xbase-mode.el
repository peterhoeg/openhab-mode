;;; xbase-mode.el --- base mode for various openhab modes

;; Copyright © 2021, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU
;; General Public License version 2.

;;; Commentary:

;; Base mode for various openHAB modes in Emacs

;;; Code:

(defvar xbase-mode-hook nil)

(define-derived-mode xbase-mode java-mode "xbase"
  "Major mode base for various openHAB modes."
  (run-hooks 'xbase-mode-hook))

(provide 'xbase-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; xbase-mode.el ends here
