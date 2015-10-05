;;
;; CS 161 Homework 1
;; Name: Darin Minamoto
;; UID: 704140102
;;

;;
;; Overall comment: I used lots of recursion and 
;; condition expressions to implement these functions
;;

;; Checks if a tree contains the specific number
;; :param: n the number to check if it is inside the tree
;; :param: tree an ordered tree 
;; :returns: a boolean value (t or nil) indicating if the tree contains the specific number
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
;; :param: tree an ordered tree 
;; :returns: the maximum value in the tree as a number
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
;; :param: tree an ordered tree 
;; :returns: an in-ordered list of all of the numbers appearing in the ordered tree
(defun tree-order (tree)
  (cond
    ((listp tree) (append
                    (tree-order (first tree))
                    (tree-order (second tree))
                    (tree-order (third tree))))
    (t (list tree))))

;; Returns a sub-list from a start position with a certain length
;; :param: l a list
;; :param: start the start position of the new sublist (zero-indexed format)
;; :param: len the length of the new sublist
;; :returns: a sublist with length len starting at position start
(defun sub-list (l start len)
  (cond
    ((equal len 0) nil)
    ((not (equal start 0)) (sub-list (cdr l) (- start 1) len))
    (t (cons (car l) (sub-list (cdr l) start (- len 1))))))

;; Returns a list with split lists
;; :param: l a list
;; :returns:  a list of two lists L1 and L2, in that order, such that L is the 
;; result of appending L1 and L2 and the length of L2 minus length of L1 is 0 or 1
(defun split-list (l)
  (let ((mid (cond
               ((oddp (length l)) (/ (- (length l) 1) 2))
               (t (/ (length l) 2)))))
    (list (sub-list l 0 mid) (sub-list l mid (- (length l) mid)))))

;; Returns the height of a binary tree
;; :param: tree a binary tree
;; :returns: the height of the binary tree as a number
(defun btree-height (tree)
  (cond
    ((numberp tree) 0)
    ((listp tree) (let ((left-height (btree-height (first tree)))
                        (right-height (btree-height (second tree))))
                    (if (> left-height right-height)
                      (+ left-height 1)
                      (+ right-height 1))))))

;; Returns a binary tree from a list
;; :param: leaves a non-empty list of atoms 
;; :returns: a binary tree such that the tree leaves are the elements of LEAVES and
;; for any internal (non-leaf) node in the tree, the number of leaves in its right branch minus the
;; number of leaves in its left branch is 0 or 1
(defun list2btree (leaves)
  (cond
    ((= (length leaves) 1) (car leaves))
    ((= (length leaves) 2) leaves)
    (t (let ((newlist (split-list leaves)))
         (let ((left (first newlist))
               (right (second newlist)))
           (list (cond 
                   ((listp left) (list2btree left))
                   (t left))
                 (cond
                   ((listp right) (list2btree right))
                   (t right))))))))

;; Returns a list from a binary tree
;; :param: tree a binary tree
;; :returns: a list of atoms
(defun btree2list (tree)
  (cond
    ((numberp tree) (list tree))
    ((listp tree) (append (btree2list (first tree))
                          (btree2list (second tree))))))

