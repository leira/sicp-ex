#lang racket

;; Exercise 1.38: In 1737, the Swiss mathematician Leonhard Euler published a
;; memoir De Fractionibus Continuis, which included a continued fraction
;; expansion for e-2, where e is the base of the natural logarithms. In this
;; fraction, the $N_i$ are all 1, and the $D_i$ are successively 1, 2, 1, 1, 4,
;; 1, 1, 6, 1, 1, 8, …. Write a program that uses your `cont-frac` procedure
;; from Exercise 1.37 to approximate e, based on Euler’s expansion.

(require "ex1.37.rkt")

(define (e-2 n)
  (cont-frac (λ (i) 1)
             (λ (i)
               (if (= (remainder i 3) 2)
                   (* (/ (+ i 1) 3) 2)
                   1))
             n))

(module+ test
  (require rackunit)
  (check-= (e-2 10) 0.718281828 0.000001))

