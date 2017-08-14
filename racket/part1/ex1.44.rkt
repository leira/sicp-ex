#lang racket

;; Exercise 1.44: The idea of *smoothing* a function is an important concept in
;; signal processing. If f is a function and dx is some small number, then the
;; smoothed version of f is the function whose value at a point x is the average
;; of f(x−dx), f(x), and f(x+dx). Write a procedure `smooth` that takes as input
;; a procedure that computes f and returns a procedure that computes the
;; smoothed f. It is sometimes valuable to repeatedly smooth a function (that
;; is, smooth the smoothed function, and so on) to obtain the *n-fold smoothed
;; function*. Show how to generate the n-fold smoothed function of any given
;; function using smooth and repeated from Exercise 1.43.

(require "part1-helpers.rkt")
(require "ex1.43.rkt")

(define dx 0.00001)
(define (smooth f)
  (λ (x)
    (average (f (- x dx))
             (f x)
             (f (+ x dx)))))
             
(define (n-fold-smooth n)
  (repeated smooth n))

;; test cases borrowed from
;; https://github.com/harpreet/sicp/blob/master/src/sicp/ex1_44.clj

;; borrowing an idea from Drew Hess' solutions, we generate a test impulse
;; function
(define (impulse-maker x a)
  (λ (y) (if (= y x)
      	     a
      	     0)))

;; we define a function which has an impulse at x=2 with a value 10.
(define (my-impulse-func x)
  ((impulse-maker 2 10) x))

(module+ test
  (require rackunit)
  (check-= ((smooth my-impulse-func) 2) 3.333333 0.000001)
  (check-= ((smooth my-impulse-func) 1) 0.0 0.000001)
  (check-= ((smooth (smooth my-impulse-func)) 2) 3.333333 0.000001)
  (check-= ((smooth (smooth (smooth my-impulse-func))) 2) 2.5925925 0.000001)

  (check-= (((n-fold-smooth 1) my-impulse-func) 2) 3.333333 0.000001)
  (check-= (((n-fold-smooth 2) my-impulse-func) 2) 3.333333 0.000001)
  (check-= (((n-fold-smooth 3) my-impulse-func) 2) 2.5925925 0.000001))

