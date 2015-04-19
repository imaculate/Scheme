;; Sample spec for automarker
;; This isn't our final test cases, this is just so you can:
;; 1) Write some of your own tests for correctness
;; 2) Verify that your methods conform to the interfaces we expect
;; 3) Verify that your program is going to work with the automarker
;; 
;; Note that the mark allocations here are arbitrary; we will likely use
;; completely different test cases and are only included here for reference.

(load "automarker/marking_fns.scm")

(define tests (list
    (list "Sample tests for the index method"
        ;; The marks are set to 0 to not mess with other marking
        (list "test first index" 0 'index '((1 2 3 4 5) 0) '(exactly-equal 1))
        (list "test fourth index" 0 'index '((1 2 3 4 5) 3) '(exactly-equal 4))
    )

    (list "Sample tests for the in method"
        ;; The marks are set to 0 to not mess with other marking
        (list "test basic in" 0 'in '(1 (1 2 3)) '(assert-true))
        (list "test basic not in" 0 'in '(4 (1 2 3)) '(assert-false))
        (list "test basic in for lists" 0 'in '((1 2) ((1 2) 3)) '(assert-true))
    )

    (list "Sample tests for the length method"
        ;; The marks are set to 0 to not mess with other marking
        (list "test length basic" 0 'length '((1 2 3 4)) '(exactly-equal 4))
        (list "test length for small list" 0 'length '((1)) '(exactly-equal 1))
        (list "test length for list of lists" 0 'length '(((1 2) (3 4))) '(exactly-equal 2))
    )

    (list "Sample tests for the recalculateOrientation method"
        ;; The marks are set to 0 to not mess with other marking
        (list "test recalculating orientation for 1 0" 0 'recalculateOrientation 
            '(1 0) 
            '(exactly-equal 2))
        (list "test recalculating orientation for 5 0" 0 'recalculateOrientation 
            '(5 0) 
            '(exactly-equal 5))
        (list "test recalculating orientation for 1 1" 0 'recalculateOrientation 
            '(1 1) 
            '(exactly-equal 1))
        (list "test recalculating orientation for 2 1" 0 'recalculateOrientation 
            '(2 1) 
            '(exactly-equal 6))
        (list "test recalculating orientation for 1 2" 0 'recalculateOrientation 
            '(1 2) 
            '(exactly-equal 5))
        (list "test recalculating orientation for 2 2" 0 'recalculateOrientation 
            '(2 2) 
            '(exactly-equal 2))
    )

    (list "Tests for rotate"
        ;; Using this to test for rotateX, rotateY and rotateZ
        (list "test rotateX" 1 'rotate 
              '("x" ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))
              '(exactly-equal '((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3))))
        (list "test rotateY" 1 'rotate
              '("y" ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))
              '(exactly-equal '((1 1) (2 1) (3 1) (4 1) (6 3) (8 3) (5 3) (7 3))))
        (list "test rotateZ" 1 'rotate 
              '("z" ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))
              '(exactly-equal '((2 5) (6 6) (3 1) (4 1) (1 5) (5 6) (7 3) (8 3))))
        (list "test rotate xYz" 1 'rotate 
              '("xYz" ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))
              '(exactly-equal '((2 5) (7 1) (1 2) (4 1) (5 4) (3 3) (8 3) (6 3))))
    )

    (list "Tests for generateSuccessorStates"
          (list "test with no previous moves" 1 'generateSuccessorStates
            '(((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)) ())
            '(state-list-equal '((((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3))
              ((3 4) (2 1) (7 2) (4 1) (1 4) (6 3) (5 2) (8 3))
              ((1 1) (2 1) (3 1) (4 1) (6 3) (8 3) (5 3) (7 3))
              ((1 1) (2 1) (3 1) (4 1) (7 3) (5 3) (8 3) (6 3))
              ((2 5) (6 6) (3 1) (4 1) (1 5) (5 6) (7 3) (8 3))
              ((5 5) (1 6) (3 1) (4 1) (6 5) (2 6) (7 3) (8 3)))
             (("x")
              ("X")
              ("y")
              ("Y")
              ("z")
              ("Z")))))

          (list "test with previous moves" 1 'generateSuccessorStates
            '(((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)) ("x" "y" "z"))
            '(state-list-equal '((((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3))
              ((3 4) (2 1) (7 2) (4 1) (1 4) (6 3) (5 2) (8 3))
              ((1 1) (2 1) (3 1) (4 1) (6 3) (8 3) (5 3) (7 3))
              ((1 1) (2 1) (3 1) (4 1) (7 3) (5 3) (8 3) (6 3))
              ((2 5) (6 6) (3 1) (4 1) (1 5) (5 6) (7 3) (8 3))
              ((5 5) (1 6) (3 1) (4 1) (6 5) (2 6) (7 3) (8 3)))
             (("x" "y" "z" "x")
              ("x" "y" "z" "X")
              ("x" "y" "z" "y")
              ("x" "y" "z" "Y")
              ("x" "y" "z" "z")
              ("x" "y" "z" "Z")))))
    )

    (list "Tests for genStates"
        (list "test output produced correctly for 0" 1 'genStates
           '(0 ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)) ()) 
           '(state-list-equal '((((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (()))))
        (list "test output produced correctly for 2" 1 'genStates
            '(2 ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)) ())
            '(state-list-equal '((((7 1) (2 1) (5 1) (4 1) (3 3) (6 3) (1 3) (8 3))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((5 4) (2 1) (1 2) (4 1) (6 3) (8 3) (7 5) (3 6))
                    ((5 4) (2 1) (1 2) (4 1) (3 5) (7 6) (8 3) (6 3))
                    ((2 5) (6 6) (1 2) (4 1) (5 4) (7 4) (3 2) (8 3))
                    ((7 4) (5 4) (1 2) (4 1) (6 5) (2 6) (3 2) (8 3))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((7 1) (2 1) (5 1) (4 1) (3 3) (6 3) (1 3) (8 3))
                    ((3 4) (2 1) (7 2) (4 1) (6 3) (8 3) (1 5) (5 6))
                    ((3 4) (2 1) (7 2) (4 1) (5 5) (1 6) (8 3) (6 3))
                    ((2 5) (6 6) (7 2) (4 1) (3 4) (1 4) (5 2) (8 3))
                    ((1 4) (3 4) (7 2) (4 1) (6 5) (2 6) (5 2) (8 3))
                    ((6 4) (2 1) (1 2) (4 1) (5 4) (8 3) (3 2) (7 3))
                    ((3 4) (2 1) (5 2) (4 1) (1 4) (8 3) (6 2) (7 3))
                    ((1 1) (2 1) (3 1) (4 1) (8 3) (7 3) (6 3) (5 3))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((2 5) (8 6) (3 1) (4 1) (1 5) (6 6) (5 3) (7 3))
                    ((6 5) (1 6) (3 1) (4 1) (8 5) (2 6) (5 3) (7 3))
                    ((7 4) (2 1) (1 2) (4 1) (8 4) (5 3) (3 2) (6 3))
                    ((3 4) (2 1) (8 2) (4 1) (1 4) (5 3) (7 2) (6 3))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((1 1) (2 1) (3 1) (4 1) (8 3) (7 3) (6 3) (5 3))
                    ((2 5) (5 6) (3 1) (4 1) (1 5) (7 6) (8 3) (6 3))
                    ((7 5) (1 6) (3 1) (4 1) (5 5) (2 6) (8 3) (6 3))
                    ((1 5) (6 6) (2 5) (4 1) (7 4) (5 6) (3 2) (8 3))
                    ((3 4) (6 6) (7 2) (4 1) (2 5) (5 6) (1 5) (8 3))
                    ((2 5) (6 6) (3 1) (4 1) (5 4) (8 3) (1 2) (7 3))
                    ((2 5) (6 6) (3 1) (4 1) (7 3) (1 4) (8 3) (5 2))
                    ((6 1) (5 1) (3 1) (4 1) (2 3) (1 3) (7 3) (8 3))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((6 5) (1 6) (5 5) (4 1) (7 4) (2 6) (3 2) (8 3))
                    ((3 4) (1 6) (7 2) (4 1) (5 5) (2 6) (6 5) (8 3))
                    ((5 5) (1 6) (3 1) (4 1) (2 4) (8 3) (6 2) (7 3))
                    ((5 5) (1 6) (3 1) (4 1) (7 3) (6 4) (8 3) (2 2))
                    ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
                    ((6 1) (5 1) (3 1) (4 1) (2 3) (1 3) (7 3) (8 3)))
                   (("x" "x")
                    ("x" "X")
                    ("x" "y")
                    ("x" "Y")
                    ("x" "z")
                    ("x" "Z")
                    ("X" "x")
                    ("X" "X")
                    ("X" "y")
                    ("X" "Y")
                    ("X" "z")
                    ("X" "Z")
                    ("y" "x")
                    ("y" "X")
                    ("y" "y")
                    ("y" "Y")
                    ("y" "z")
                    ("y" "Z")
                    ("Y" "x")
                    ("Y" "X")
                    ("Y" "y")
                    ("Y" "Y")
                    ("Y" "z")
                    ("Y" "Z")
                    ("z" "x")
                    ("z" "X")
                    ("z" "y")
                    ("z" "Y")
                    ("z" "z")
                    ("z" "Z")
                    ("Z" "x")
                    ("Z" "X")
                    ("Z" "y")
                    ("Z" "Y")
                    ("Z" "z")
                    ("Z" "Z")))))
    )

   (list "Tests for solveCube" 
        (list "test for 1 rotation" 1 'solveCube
            (list
              solvedStates
              '((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3))
              0)
            '(exactly-equal '("X")))  
        (list "test for 3 rotation" 1 'solveCube
           (list 
             solvedStates
             '((2 5) (8 6) (1 2) (4 1) (5 4) (6 6) (7 5) (3 6))
             0)
           '(exactly-equal '("Z" "Y" "X"))))
))
