;;; sway-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "sway" "sway.el" (0 0 0 0))
;;; Generated autoloads from sway.el

(defvar sway-undertaker-mode nil "\
Non-nil if Sway-Undertaker mode is enabled.
See the `sway-undertaker-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `sway-undertaker-mode'.")

(custom-autoload 'sway-undertaker-mode "sway" nil)

(autoload 'sway-undertaker-mode "sway" "\
The undertaker kills frames when the buffer they display is buried.

This is a minor mode.  If called interactively, toggle the
`Sway-Undertaker mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='sway-undertaker-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(defvar sway-socket-tracker-mode nil "\
Non-nil if Sway-Socket-Tracker mode is enabled.
See the `sway-socket-tracker-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `sway-socket-tracker-mode'.")

(custom-autoload 'sway-socket-tracker-mode "sway" nil)

(autoload 'sway-socket-tracker-mode "sway" "\
Try not to lose the path to the Sway socket.

This is a minor mode.  If called interactively, toggle the
`Sway-Socket-Tracker mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='sway-socket-tracker-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

A minor mode to track the value of SWAYSOCK on newly created
frames.  This is a best effort approach, and remains probably
very fragile.

\(fn &optional ARG)" t nil)

(defvar sway-x-focus-through-sway-mode nil "\
Non-nil if Sway-X-Focus-Through-Sway mode is enabled.
See the `sway-x-focus-through-sway-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `sway-x-focus-through-sway-mode'.")

(custom-autoload 'sway-x-focus-through-sway-mode "sway" nil)

(autoload 'sway-x-focus-through-sway-mode "sway" "\
Temporary fix/workaround for Sway bug #6216.

This is a minor mode.  If called interactively, toggle the
`Sway-X-Focus-Through-Sway mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='sway-x-focus-through-sway-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

Replace `x-focus-frame' with an implementation that delegates to
`sway-focus-container'.

\(fn &optional ARG)" t nil)

(autoload 'sway-shackle-display-buffer-frame "sway" "\
Show BUFFER in an Emacs frame, creating it if needed.

_ALIST is ignored, PLIST as in Shackle; also accepts a :dedicate
argument for the undertaker..

\(fn BUFFER &optional ALIST PLIST)" nil nil)

(register-definition-prefixes "sway" '("sway-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; sway-autoloads.el ends here
