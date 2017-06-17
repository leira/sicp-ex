#lang racket

;; Exercise 2.5 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e5

(define (cons a b) 
  (* (expt 2 a) (expt 3 b)))

(define (car p) 
  (extract-factor p 2))

(define (cdr p) 
  (extract-factor p 3))

(define (extract-factor x base)
  (define (iter left count)
    (if (not (= (remainder left base) 0))
        count
        (iter (/ left base) (+ count 1))))
  (iter x 0))

(module+ test
  (require rackunit)
  (define pair01 (cons 0 1))
  (check-equal? (car pair01) 0)
  (check-equal? (cdr pair01) 1)
  (define pair12 (cons 1 2))
  (check-equal? (car pair12) 1)
  (check-equal? (cdr pair12) 2)
  (define tuple123 (cons 1 (cons 2 3)))
  (check-equal? (car (cdr tuple123)) 2)
  (check-equal? (cdr (cdr tuple123)) 3))

