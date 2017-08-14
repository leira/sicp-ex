#lang racket

;; Exercise 2.65 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e65

(require "ex2.63.rkt")
(require "ex2.64.rkt")
(require (only-in "ex2.62.rkt"
                  [union-set union-set-list]
                  [intersection-set intersection-set-list]))

(define (union-set set1 set2)
  (list->tree
    (union-set-list
      (tree->list set1)
      (tree->list set2))))

(define (intersection-set set1 set2)
  (list->tree
    (intersection-set-list
      (tree->list set1)
      (tree->list set2))))

(module+ test
  (require rackunit)
  (define set1 (list->tree '(1 3 5 7 9 11)))
  (define set2 (list->tree '(2 4 5 6 7 8 9 10)))
  (define uset (list->tree '(1 2 3 4 5 6 7 8 9 10 11)))
  (define iset (list->tree '(5 7 9)))
  (check-equal? (union-set set1 set2) uset)
  (check-equal? (intersection-set set1 set2) iset)
  )

