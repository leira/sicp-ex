#lang racket/base

;; simple square function
(define (square x) (* x x))

(module+ test
  (require rackunit)
  (check-equal? (square 1) 1)
  (check-equal? (square 2) 4))

