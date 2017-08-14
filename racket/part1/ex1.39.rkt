#lang racket

;; Exercise 1.39: A continued fraction representation of the tangent function
;; was published in 1770 by the German mathematician J.H. Lambert:
;;
;; $$\tan x = \frac{x}{1-\frac{x^2}{3-\frac{x^2}{5-\cdots}}}$$
;;
;; where x is in radians. Define a procedure `(tan-cf x k)` that computes an
;; approximation to the tangent function based on Lambert’s formula. k specifies
;; the number of terms to compute, as in Exercise 1.37.

(require "part1-helpers.rkt")
(require "ex1.37.rkt")

(define (tan-cf x k)
  (cont-frac (λ (i)
               (if (= i 1)
                   x
                   (- (square x))))
             (λ (i)
               (- (* i 2) 1))
             k))

(module+ test
  (require rackunit)
  (check-= (tan-cf 0.785 10) 0.9992 0.0001))

