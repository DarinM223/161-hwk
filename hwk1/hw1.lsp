;;
;; CS 161 Homework 1
;; Name: Darin Minamoto
;;

;; Checks if a tree contains the specific number
(defun tree-contains (n tree)
  (cond
    ; if tree is a list 
    ; Check all three leaves if they have n
    ((listp tree) (or 
                    (tree-contains n (first tree)) 
                    (tree-contains n (second tree)) 
                    (tree-contains n (third tree))))
    ; if tree is value
    ; check value if tree contains it
    (t (cond 
         ((= n tree) t)
         (t nil)))))

;; Returns the maximum value in the tree
(defun tree-max (tree)
  (cond
    ((listp tree) (let ((a (tree-max (first tree)))
                        (b (tree-max (second tree)))
                        (c (tree-max (third tree))))
                    (cond 
                      ((> a b) (cond
                                 ((> a c) a)
                                 (t c)))
                      ((> b c) b)
                      (t c))))
    ((numberp tree) tree)
    (t 0)))

;; Returns a list representing the in-order traversal of the tree
(defun tree-order (tree)
  (cond
    ((listp tree) (append
                    (tree-order (first tree))
                    (tree-order (second tree))
                    (tree-order (third tree))))
    (t (list tree))))

;; Returns a sub-list from a start position with a certain length
(defun sub-list (l start len)
  (cond
    ((equal len 0) nil)
    ((not (equal start 0)) (sub-list (cdr l) (- start 1) len))
    (t (cons (car l) (sub-list (cdr l) start (- len 1))))))

