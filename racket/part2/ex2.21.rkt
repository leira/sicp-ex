#lang racket

;; Exercise 2.21 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e21

(define (square-list-recr items)
  (if (null? items)
      null
      (cons (square (car items)) (cdr items))))

(define (square-list items)
  (map square items))

(define (square x) (* x x))

(module+ test
  (require rackunit)
  (check-equal? (square-list-recr (list 1 2 3 4 5)) (list 1 4 9 16 25))
  (check-equal? (square-list (list 1 2 3 4 5)) (list 1 4 9 16 25)))

