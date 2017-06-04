#lang racket/base

(provide square)
(define (square x) (* x x))

(provide even?)
(define (even? n)
  (= (remainder n 2) 0))

(provide double)
(define (double n)
  (arithmetic-shift n 1))

(provide halve)
(define (halve n)
  (arithmetic-shift n -1))

(provide average)
(define (average x y) 
  (/ (+ x y) 2))

(provide converge?)
(define (converge? prev-guess guess epsilon)
  (< (/ (abs (- guess prev-guess)) guess) epsilon))

