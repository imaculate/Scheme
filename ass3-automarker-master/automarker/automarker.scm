#!/usr/local/Gambit-C/bin/gsi-script
;; A simple Guile Automatic Marker
;; Created by Steven Rybicki on 26 March 2015
;;
;; *******************************************************
;; Running:
;; *******************************************************
;; gsi automarker.scm spec prog
;;  - prog: the program to mark
;;  - spec: a scheme file with the test cases. Must include a variable named
;;          tests which contains all the test collections
;;
;; *******************************************************
;; Test case format:
;; *******************************************************
;; Test case format:
;; (name, mark, method, input, marking_fn)
;;
;; Test collection format:
;; (name, test_cases)
;; 
;; Tests format:
;; (test_collection_1 test_collection_2, etc)

;; Load the spec and the program to test from the command line inputs

(load "automarker/helper_fn.scm")

(define spec (cadr (command-line)))
(define prog (list-ref (command-line) 2))
(display (string-append "Running automarker using spec [" spec "] on [" prog "]\n\n"))

(load prog)
(load spec) ;; ensure that prog can't override spec methods

;; Helper display functions

(define (print arg)
  (display (string-append arg "\n"))
)
(define divider "***************************************************")
(define (print-divider) (print divider))

;; Running the tests

(define (run-tests test-collections)
  (print-test-report (map run-test-collection test-collections)))

(define (run-test-collection test-collection)
  (list (car test-collection) (map run-test (cdr test-collection))))

(define (run-test test-case)
  (let* ((method (list-ref test-case 2))
        (input (list-ref test-case 3))
        (marking-fn (list-ref test-case 4))
        (actual-output (apply (eval method) input))
        (result ((eval marking-fn) actual-output))
        )
    (append test-case (list actual-output result))))

;; Printing out the results of the mark
  
(define (print-test-report test-results)
  (begin
    (print-divider)
    (print "Test results: ")
    (print-divider)
    (for-each
        print-test-collection-results
        test-results)
    (print (string-append "Total: " (number->string (add-marks test-results))
        "/" (number->string (total-marks test-results))))
    )
)

(define (print-test-collection-results collection-results)
  (begin
    (print (string-append "Section name: " (car collection-results) "\n"))
    (for-each
      print-test-result 
      (cadr collection-results))
    (print (string-append "Total Section Mark: " (number->string (add-marks-collection collection-results))
 "/" (number->string (total-marks-collection collection-results))))
    (print-divider)
  ))

(define (print-test-result test-result)
  (if (list-ref test-result 6)
    (print-test-passed test-result)
    (print-test-failed test-result)
))

(define (print-test-passed test-result)
    (print (string-append (car test-result) " passed [" (number->string (cadr test-result)) "]")))

(define (print-test-failed test-result)
  (let ((name (car test-result)) 
        (mark (cadr test-result))
        (method (list-ref test-result 2))
        (input (list-ref test-result 3))
        (marking-fn (list-ref test-result 4))
        (actual-output (list-ref test-result 5))
        )
    (begin 
        (display (string-append name " failed"
                                     " [" (number->string mark) "]"
                                     "\n"
                                     "    Method: " (symbol->string method) 
                                     "\n"
                                     "    Input: "))
        (pretty-print input)
        (display (string-append "    Marking function: "))
        (pretty-print marking-fn)
        (display (string-append "    Output given: "))
        (pretty-print actual-output)
        (print "")
    )
))

;; Mark totalling

(define (add-marks test-results)
  (reduce + 0 (map add-marks-collection test-results))
)

(define (add-marks-collection collection-results)
  (reduce + 0 
    (map (lambda (test-result)
        (if (list-ref test-result 6)
          (list-ref test-result 1)
          0))
         (cadr collection-results)
    ) 
  )
)

(define (total-marks test-results)
    (reduce + 0 (map total-marks-collection test-results))
)

(define (total-marks-collection collection-results)
    (reduce + 0
        (map (lambda (test-result) (list-ref test-result 1))
            (cadr collection-results))
    )
)

;; Running the automarker
(run-tests tests)
