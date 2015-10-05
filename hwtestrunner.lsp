
;;
;; This file contains the function to run the test cases for each homework.
;; Do not run this file directly, instead call (run-tests tests) inside
;; a test file for each homework and run that test file instead.
;;

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

