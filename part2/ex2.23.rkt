#lang racket

;; Exercise 2.23 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e23

(define (for-each proc items)
  (when (not (null? items))
        (proc (car items))
        (for-each proc (cdr items))))

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))

