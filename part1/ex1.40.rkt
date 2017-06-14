#lang racket

;; Exercise 1.40: Define a procedure cubic that can be used together with the
;; newtons-method procedure in expressions of the form
;;
;; (newtons-method (cubic a b c) 1)
;;
;; to approximate zeros of the cubic $x^3+ax^2+bx+cx$.

(require "part1-helpers.rkt")

(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) 
            ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) 
               guess 0.00001))
               
(define (cubic a b c)
  (λ (x)
    (+ (cube x) (* a (square x)) (* b x) c)))

(define (solve-cubic a b c)
  (newtons-method (cubic a b c) 1))

(module+ test
  (require rackunit)
  (check-= (solve-cubic 1 2 3) -1.2757 0.0001))

