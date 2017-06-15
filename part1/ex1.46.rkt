#lang racket

;; Exercise 1.46: Several of the numerical methods described in this chapter are
;; instances of an extremely general computational strategy known as *iterative
;; improvement*. Iterative improvement says that, to compute something, we start
;; with an initial guess for the answer, test if the guess is good enough, and
;; otherwise improve the guess and continue the process using the improved guess
;; as the new guess. Write a procedure `iterative-improve`that takes two
;; procedures as arguments: a method for telling whether a guess is good enough
;; and a method for improving a guess. `Iterative-improve` should return as its
;; value a procedure that takes a guess as argument and keeps improving the
;; guess until it is good enough. Rewrite the sqrt procedure of 1.1.7 and the
;; `fixed-point` procedure of 1.3.3 in terms of `iterative-improve`.

(require "part1-helpers.rkt")

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
          next
          (try next))))
  try)

(define tolerance 0.00001)
(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) 
     tolerance))

(define (sqrt x)
  ((iterative-improve
    close-enough?
    (average-damp (λ (y) (/ x y)))) 1.0))

(module+ test
  (require rackunit)
  (check-= (sqrt 2) 1.41421356237 tolerance))

(define (fixed-point f first-guess)
  ((iterative-improve close-enough? f) first-guess))

(module+ test
  (check-= (fixed-point (λ (x) (+ 1 (/ 1 x))) 1.0) 1.61803398875 tolerance))

