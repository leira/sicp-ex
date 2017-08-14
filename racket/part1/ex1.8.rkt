#lang racket/base

;; Exercise 1.8: Newton’s method for cube roots is based on the fact that if y
;; is an approximation to the cube root of xx, then a better approximation is
;; given by the value
;; $$\frac{x/y^2+2y}{3}$$
;; Use this formula to implement a cube-root procedure analogous to the
;; square-root procedure. (In 1.3.4 we will see how to implement Newton’s method
;; in general as an abstraction of these square-root and cube-root procedures.)

(require "part1-helpers.rkt")

(define (cube-root x) 
  (define (improve guess x)
    (/ (+ (/ x (square guess))
          (* 2 guess))
       3))
  (define (cube-root-iter prev-guess guess x epsilon)
    (if (converge? prev-guess guess epsilon)
        guess
        (cube-root-iter guess (improve guess x) x epsilon)))
  (cube-root-iter 0 1.0 x 0.001))

(module+ test
  (require rackunit)
  (define (choose-epsilon x) (* x 0.001))
  (check-= (cube-root 3) 1.4422 (choose-epsilon 1.4422))
  (check-= (cube-root 1000) 10.0 (choose-epsilon 10.0))
  (check-= (cube-root 0.001) 0.1 (choose-epsilon 0.1)))

