#lang racket/base

;; Exercise 1.7: The good-enough? test used in computing square roots will not
;; be very effective for finding the square roots of very small numbers. Also,
;; in real computers, arithmetic operations are almost always performed with
;; limited precision. This makes our test inadequate for very large numbers.
;; Explain these statements, with examples showing how the test fails for small
;; and large numbers. An alternative strategy for implementing good-enough? is
;; to watch how guess changes from one iteration to the next and to stop when
;; the change is a very small fraction of the guess. Design a square-root
;; procedure that uses this kind of end test. Does this work better for small
;; and large numbers?

(require "part1-helpers.rkt")

(define (sqrt x) 
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter prev-guess guess x epsilon)
    (if (converge? prev-guess guess epsilon)
        guess
        (sqrt-iter guess (improve guess x) x epsilon)))
  (sqrt-iter 0 1.0 x 0.001))

(module+ test
  (require rackunit)
  (define (choose-epsilon x) (* x 0.001))
  (check-= (sqrt 2) 1.414 (choose-epsilon 1.414))
  (check-= (sqrt 1000000000000) 1000000.0 (choose-epsilon 1000000.0))
  (check-= (sqrt 0.00000001) 0.0001 (choose-epsilon 0.0001)))

