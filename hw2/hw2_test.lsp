;;
;; Tests for homework 2
;;

(load "hw2.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
                ((dfs '((w x) (y z))) (w x y z) "dfs1")
                ((dfs '((a (b)) c (d))) (a b c d) "dfs2")
                ((dfs '(a (b c) (d) (e (f g)))) (a b c d e f g) "dfs3")
                ((dfs '((a (b) (c (d))) ((e f)) ((g h) i))) (a b c d e f g h i) "dfs4")
                ((dfid '((w x) (y z)) 2) (w x y z) "dfid1")
                ((dfid '((a (b)) c (d)) 3) (c a c d a b c d) "dfid2")
                ((dfid '(a (b c) (d) (e (f g))) 3) (a a b c d e a b c d e f g) "dfid3")
                ((dfid '((a (b) (c (d))) (e f) ((g h) i)) 4) (a e f i a b c e f g h i a b c d e f g h i) "dfid4")
                ((final-state '(1 0 nil)) nil "final-state1")
                ((final-state '(3 3 nil)) T "final-state2")
                ((final-state '(3 3 T)) nil "final-state3")
                ((next-state '(3 3 T) 1 0) nil "next-state1")
                ((next-state '(3 1 T) 1 0) nil "next-state2")
                ((next-state '(0 1 nil) 2 0) nil "next-state3")
                ((next-state '(3 3 T) 1 1) ((1 1 nil)) "next-state4")
                ((next-state '(3 3 T) 0 2) ((0 2 nil)) "next-state5")
                ((next-state '(3 1 nil) 2 0) ((2 2 T)) "next-state6")
                ((succ-fn '(3 3 T)) ((0 1 nil) (1 1 nil) (0 2 nil)) "succ-fn1")
                ((succ-fn '(1 1 T)) ((3 2 nil) (3 3 nil)) "succ-fn2")
                ((succ-fn '(0 3 nil)) ((3 1 T) (3 2 T)) "succ-fn3")
                ((succ-fn '(3 0 nil)) nil "succ-fn4")
                ((on-path '(3 2 T) '((1 2 nil) (1 0 T) (3 2 T) (2 1 T))) T "on-path1")
                ((on-path '(3 0 nil) '((1 2 nil) (1 0 T))) nil "on-path2")
                ((on-path '(3 3 T) '((1 1 T) (2 2 NIL) (3 3 T))) T "on-path3")
                ((mult-dfs '((0 1 NIL) (1 1 NIL) (0 2 NIL)) '((3 3 T))) ((3 3 T) (1 1 NIL) (3 2 T) (0 3 NIL) (3 1 T) (2 2 NIL) (2 2 T) (3 1 NIL) (0 3 T) (3 2 NIL) (1 1 T) (3 3 NIL)) "mult-dfs1")
                ((mult-dfs NIL '((3 3 T))) NIL "mult-dfs2")
                ((mc-dfs '(3 3 T) NIL) ((3 3 T) (1 1 NIL) (3 2 T) (0 3 NIL) (3 1 T) (2 2 NIL) (2 2 T) (3 1 NIL) (0 3 T) (3 2 NIL) (1 1 T) (3 3 NIL)) "mc-dfs1")
                ((mc-dfs '(3 3 NIL) NIL) ((3 3 NIL)) "mc-dfs2")
                ((mc-dfs '(1 1 NIL) '((3 3 T) (1 1 NIL) (3 2 T))) NIL "mc-dfs3")
            ))

(run-tests tests)

