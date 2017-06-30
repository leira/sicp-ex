#lang racket

;; Exercise 2.54 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e54

(define (equal? x y)
  (if (and (pair? x) (pair? y))
      (and (equal? (car x) (car y))
           (equal? (cdr x) (cdr y)))
      (eq? x y)))
(module+ test
  (require rackunit)
  (check-true (equal? 'a 'a))
  (check-false (equal? '(a) 'a))
  (check-false (equal? null 'a))
  (check-false (equal? '(a) null))
  (check-true (equal? (cons 'a 'b) (cons 'a 'b)))
  (check-true (equal? (cons 'a '(b c)) (cons 'a '(b c))))
  (check-true (equal? '(this is a list) '(this is a list)))
  (check-false (equal? '(this is a list) '(this (is a) list))))

