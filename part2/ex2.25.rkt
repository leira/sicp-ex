#lang racket

;; Exercise 2.25 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e25

(require rackunit)

(define l1 '(1 3 (5 7) 9))
(check-equal? (car (cdr (car (cdr (cdr l1))))) 7)
(check-equal? (car (cdaddr l1)) 7)

(define l2 '((7)))
(check-equal? (car (car l2)) 7)
(check-equal? (caar l2)  7)

(define (compose f g)
  (λ (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define l3 '(1 (2 (3 (4 (5 (6 7)))))))
(check-equal? ((repeated (compose car cdr) 6) l3) 7)
(check-equal? ((repeated cadr 6) l3) 7)

