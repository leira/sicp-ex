#lang racket

;; Exercise 2.61 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e61

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set))
          (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(module+ test
  (require rackunit)
  (check-equal? (adjoin-set 1 '()) '(1))
  (check-equal? (adjoin-set 2 '(1 2 3 4)) '(1 2 3 4))
  (check-equal? (adjoin-set 3 '(1 2 4 5)) '(1 2 3 4 5))
  (check-equal? (adjoin-set 1 '(2 3 4 5)) '(1 2 3 4 5))
  )

