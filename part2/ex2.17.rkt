#lang racket

;; Exercise 2.17 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e17

(define (last-pair l)
  (define (last prev l)
    (if (null? l)
        prev
        (last (car l) (cdr l))))
  (last null l))

(module+ test
  (require rackunit)
  (check-equal? (last-pair (list)) null)
  (check-equal? (last-pair (list 1)) 1)
  (check-equal? (last-pair (list 1 2 3 4)) 4))

