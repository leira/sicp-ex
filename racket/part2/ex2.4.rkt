#lang racket

;; Exercise 2.4 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e4

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z) 
  (z (lambda (p q) q)))

(module+ test
  (require rackunit)
  (define pair12 (cons 1 2))
  (check-equal? (car pair12) 1)
  (check-equal? (cdr pair12) 2)
  (define tuple123 (cons 1 (cons 2 3)))
  (check-equal? (car (cdr tuple123)) 2)
  (check-equal? (cdr (cdr tuple123)) 3))

