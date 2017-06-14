#lang racket/base

(provide square)
(define (square x) (* x x))

(provide cube)
(define (cube x) (* x x x))

(provide even?)
(define (even? n)
  (= (remainder n 2) 0))

(provide odd?)
(define (odd? n)
  (= (remainder n 2) 1))

(provide double)
(define (double n)
  (arithmetic-shift n 1))

(provide halve)
(define (halve n)
  (arithmetic-shift n -1))

(provide average)
(define (average . args)
  (/ (apply + args) (length args)))

(provide converge?)
(define (converge? prev-guess guess epsilon)
  (< (/ (abs (- guess prev-guess)) guess) epsilon))

(provide runtime)
(define (runtime)
  (inexact->exact (truncate (* 1000 (current-inexact-milliseconds)))))

(provide inc)
(define (inc n) (+ n 1))

(provide identity)
(define (identity x) x)

(provide fixed-point)
(define (fixed-point f first-guess tolerance)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

