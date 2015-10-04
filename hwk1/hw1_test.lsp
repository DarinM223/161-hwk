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
              ((tree-order '((1 2 3) 7 8)) (1 2 3 7 8) "Testing tree order with many elements")
              ;; SUB-LIST tests
              ((sub-list '(a b c d) 0 3) (a b c) "Testing sub-list")
              ((sub-list '(a b c d) 3 1) (d) "Testing sub-list with length of 1")
              ((sub-list '(a b c d) 2 0) nil "Testing sub-list with length of 0")
              ;; SPLIT-LIST tests
              ((split-list '(a b c d)) ((a b) (c d)) "Testing split list with even length")
              ((split-list '(a b c d e)) ((a b) (c d e)) "Testing split list with odd length")
              ((split-list '(a b c d e f)) ((a b c) (d e f)) "Testing split list with larger length")
              ))

(run-tests tests)

