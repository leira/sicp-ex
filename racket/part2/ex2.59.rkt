#lang racket

;; Exercise 2.59 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e59

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
          (union-set (cdr set1)
                     set2))
        (else (cons (car set1)
                    (union-set (cdr set1)
                               set2)))))
(module+ test
  (require rackunit)
  (check-equal? (union-set '(1 2 3 4)
                           '(1 4 5 6))
                '(2 3 1 4 5 6))
  (check-equal? (union-set '()
                           '(1 4 5 6))
                '(1 4 5 6))
  (check-equal? (union-set '(1 2 3 4)
                           '())
                '(1 2 3 4)))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

