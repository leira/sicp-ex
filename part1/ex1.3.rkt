#lang racket/base

;; Exercise 1.3: Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (squares-sum-of-larger-two a b c)
  (sum-of-squares (max a b)
                  (max (min a b) c)))

(module+ test
  (require rackunit)
  (check-equal? (squares-sum-of-larger-two 1 2 3) 13)
  (check-equal? (squares-sum-of-larger-two 2 2 2) 8)
  (check-equal? (squares-sum-of-larger-two 2 2 3) 13)
  (check-equal? (squares-sum-of-larger-two 2 3 3) 18))

