#lang racket

;; Exercise 2.60 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e60

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        (else (filter (λ (x) (element-of-set? x set2)) set1))))

(define (union-set set1 set2)
  (append set1 set2))

(module+ test
  (require rackunit)
  (check-true (element-of-set? 1 '(1 1 2 3 3 4)))
  (check-equal? (adjoin-set 1 '(1 2 3 4)) '(1 1 2 3 4))
  (check-equal? (intersection-set '(1 1 2 3 3 4)
                                  '(1 1 4 2 2 6))
                '(1 1 2 4))
  (check-equal? (union-set '(1 2 3 4)
                           '(1 4 5 6))
                '(1 2 3 4 1 4 5 6))
  )

