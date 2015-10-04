;;
;; Tests for homework 1
;;

(load "hw1.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
              ;; TREE-CONTAINS tests
              ((tree-contains 3 '((1 2 3) 7 8)) t "Testing if element is in list") 
              ((tree-contains 4 '((1 2 3) 7 8)) nil "Testing if element is not in list")
              ;; TREE-MAX tests
              ((tree-max '((1 2 3) 7 8)) 8 "Testing if the max element in tree is returned")
              ;; TREE-ORDER tests
              ((tree-order 3) (3) "Testing tree order with one element")
              ((tree-order '((1 2 3) 7 8)) (1 2 3 7 8) "Testing tree order with many elements")))

(run-tests tests)

