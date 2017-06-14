#lang racket

;; Exercise 1.41: Define a procedure double that takes a procedure of one
;; argument as argument and returns a procedure that applies the original
;; procedure twice. For example, if inc is a procedure that adds 1 to its
;; argument, then (double inc) should be a procedure that adds 2. What value is
;; returned by

(require "part1-helpers.rkt")

(define (double f)
  (λ (x)
    (f (f x))))

(module+ test
  (require rackunit)
  ;; (double (double double)) applies f for $(2^2)^2 = 16$ times
  (check-equal? (((double (double double)) inc) 5) 21))

