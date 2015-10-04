
;; Runs all tests
(defun run-tests (tests)
  (let ((test (car tests))
	(rest (cdr tests)))
    (cond
      ((null test) "All tests completed")
      ((equal (eval (nth 0 test)) (nth 1 test))
       (print (format nil "SUCCESS: ~A" (nth 2 test)))
	(run-tests rest))
      (t (print (format nil "FAIL: ~A" (nth 2 test)))))))

