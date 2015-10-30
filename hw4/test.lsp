(load "hw4.lsp")

; writes to a file "test.txt"

(defvar cmds)
; cmds is a list of (command result) tuples. The first element in the tuple will be evaluated as a command, and the second output will be printed as the correct output
(setq cmds '(((time (queens 1)))
             ((time (queens 2)))
             ((time (queens 3)))
             ((time (queens 4)))
             ((time (queens 5)))
             ((time (queens 6)))
             ((time (queens 7)))
             ((time (queens 8)))
             ((time (queens 9)))
             ((time (queens 10)))
             ((time (queens 11)))
             ((time (queens 12)))
             ((time (queens 13)))
             ((time (queens 14)))
             ((time (queens 15)))))

(defun print-cmd-output (cmdobj stream)
  (let ((cmd (car cmdobj))
        (ans (cadr cmdobj)))
    (format stream "> ~a~%" cmd)
    (format stream "~a~%~%" (eval cmd))))
;(format stream "~a <--correct output~%~%" ans)))

(defun print-cmd-list (cmds stream)
  (cond ((null (cdr cmds)) (print-cmd-output (car cmds) stream));(print (eval (car cmds)) stream))
        (t (let () 
             (print-cmd-output (car cmds) stream) 
             (print-cmd-list (cdr cmds) stream)))))

(with-open-file (*standard-output* "test.txt" 
                                   :direction :output
                                   :if-exists :overwrite
                                   :if-does-not-exist :create)
  (print-cmd-list cmds *standard-output*))
