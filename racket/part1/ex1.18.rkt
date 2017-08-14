#lang racket/base

;; Exercise 1.18: Using the results of Exercise 1.16 and Exercise 1.17, devise
;; a procedure that generates an iterative process for multiplying two integers
;; in terms of adding, doubling, and halving and uses a logarithmic number of
;; steps.

(require "part1-helpers.rkt")

(define (* a b)
  (define (*-iter p a b)
    (cond ((= b 0) 
            p)
          ((even? b) 
            (*-iter p (double a) (halve b)))
          (else 
            (*-iter (+ p a) a (- b 1)))))
  (*-iter 0 a b))

(module+ test
  (require rackunit)
  (check-equal? (* 2 0) 0)
  (check-equal? (* 2 1) 2)
  (check-equal? (* 2 4) 8)
  (check-equal? (* 2 5) 10))

