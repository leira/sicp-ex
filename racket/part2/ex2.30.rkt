#lang racket

;; Exercise 2.30 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e30

(define (square x) (* x x))

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (square sub-tree)))
       tree))

(module+ test
  (require rackunit)
  (define to (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7)))
  (define ts (list 1
                   (list 4 (list 9 16) 25)
                   (list 36 49)))
  (check-equal? (square-tree to) ts))

