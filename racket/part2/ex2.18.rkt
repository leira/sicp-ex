#lang racket

;; Exercise 2.18 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e18

(define (reverse l)
  (define (rev result remain)
    (if (null? remain)
        result
        (rev (cons (car remain)
                   result)
             (cdr remain))))
  (rev null l))

(module+ test
  (require rackunit)
  (check-equal? (reverse (list)) null)
  (check-equal? (reverse (list 1)) (list 1))
  (check-equal? (reverse (list 1 2 3 4)) (list 4 3 2 1)))

