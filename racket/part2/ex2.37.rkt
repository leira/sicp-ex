#lang racket

;; Exercise 2.37 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e37

(require "ex2.36.rkt")

(define (dot-product v w)
  (foldr + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (λ (w) (dot-product v w)) m))

(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (λ (v) (matrix-*-vector cols v))
         m)))

(module+ test
  (require rackunit)
  (define m1 '((1 2 3)
               (4 5 6)))
  (define m2 '((7 8)
               (9 10)
               (11 12)))
  (define mr '((58 64)
               (139 154)))
  (check-equal? (matrix-*-matrix m1 m2) mr))

