; Name: Darin Minamoto
; UID: 704140102

(defun reload ()
  (load "hw4.lsp"))

; Main n-queens function
(defun queens (n)
  (dfs (cons '() (list (generate-state n))) n))

(defun dfs-helper (states n)
  (cond 
    ((null states) nil)
    (t 
      (or (dfs (first states) n) (dfs-helper (rest states) n)))))

(defun place-queen (s queen-col) (update s queen-col))

(defun dfs (s n)
  (let* ((queens (first s))
         (full-state (second s))
         (num-queens-placed (length queens)))
    (cond 
      ((and (= n num-queens-placed)) queens) 
      (t
        (dfs-helper (succ s n) n))))) 

(defun state-valid (s) 
  (let* ((col-options (first s))) 
    (and (or (null s) col-options)  
         (= (count nil s) 0)
         (cond 
           ((null s) t)
           ((= 1 (length col-options)) 
            (state-valid (place-queen s (first col-options))))
           (t (state-valid (rest s)))))))

(defun succ (s n)
  (let* ((queens (first s))
         (state (second s))
         (col-options (first state)))
    (succ-helper queens col-options state n '())))

(defun succ-helper (queens move-options s n succ-states)
  (cond 
    ((null move-options) succ-states)
    (t
      (let* ((add-queen (first move-options)) 
             (res-queens (append queens (list add-queen))) 
             (res-state (place-queen s add-queen)) 
             (new-state (cons res-queens (list res-state))))
        (cond 
          ((not (state-valid res-state)) 
           (succ-helper queens (rest move-options) s n succ-states))
          (t 
            (succ-helper queens (rest move-options) s n (cons new-state succ-states))))))))

(defun generate-state (n) (generate-lists n n))

(defun generate-lists (n dec)
  (cond 
    ((= dec 1) (list (generate-list n)))
    (t (cons (generate-list n) (generate-lists n (- dec 1))))))

(defun generate-list (n)
  (cond 
    ((= n 1) '(1))
    (t (append (generate-list (- n 1)) (list n)))))

(defun set-nth (l n v)
  (let ((len (length l)))
    (cond 
      ((> n len) nil)
      (t (append (butlast l (- len n -1)) (list v) (nthcdr n l))))))

(defun remove-val (l v)
  (remove-val-helper l v '()))

(defun remove-val-helper (l v build-l)
  (cond 
    ((null l) build-l)
    ((= (first l) v) (append build-l (rest l)))
    (t (remove-val-helper (rest l) v (append build-l (list (first l)))))))

(defun remove-left-col-right (l left col right)
  (remove-left-col-right-helper l left col right '()))

(defun remove-left-col-right-helper (l left col right build-l)
  (let ((curr-v (first l)))
    (cond 
      ((null l) build-l)
      ((or (= curr-v left) (= curr-v col) (= curr-v right))
       (remove-left-col-right-helper (rest l) left col right build-l))
      (t (remove-left-col-right-helper (rest l) left col right (append build-l (list curr-v)))))))

(defun update (s col) (rest (update-helper '() s col col col)))

(defun update-helper (state-build state-remaining l col r)
  (cond 
    ((null state-remaining) state-build)
    (t
      (let ((new-row (update-row (first state-remaining) l col r)))
        (update-helper (append state-build (list new-row))
                          (rest state-remaining)
                          (- l 1) ;update-leftrightward l 'l '() n)
                          col
                          (+ r 1))))))

(defun update-row (row l col r)
  (remove-left-col-right row l col r))

(defun add-queen (s col)
  (let ((new-s (append s (list col))))
    (cond 
      ((check-valid new-s) new-s)
      (t nil))))

(defun check-valid (s) (check-valid-helper s 1 '() '()))

(defun check-valid-helper (queens rown cols coords)
  (cond 
    ((null queens) t)
    (t 
      (cond ((or (> (count (first queens) cols) 0) 
                 (diagonals-exist (cons rown (first queens)) coords)) nil)
            (t (check-valid-helper (rest queens) 
                                   (+ rown 1) 
                                   (cons (first queens) cols)
                                   (cons (cons rown (first queens)) coords)))))))

(defun diagonals-exist (coord coords)
  (let ((x1 (first coord))
        (x2 (first (first coords)))
        (y1 (rest coord))
        (y2 (rest (first coords))))
    (cond 
      ((null coords) nil)
      ((= 1 (my-abs (/ (- y2 y1) (- x2 x1)))) t)
      (t (diagonals-exist coord (rest coords))))))

(defun my-abs (val)
  (cond 
    ((< val 0) (* val -1))
    (t val)))

