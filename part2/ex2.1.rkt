#lang racket

;; Exercise 2.1 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e1

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d)))
        (sign (if (< d 0) - identity)))
    (cons (sign (/ n g))
          (sign (/ d g)))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (identity x) x)

(module+ test
  (require rackunit)
  (define (check-rat rat n d)
    (check-equal? (numer rat) n)
    (check-equal? (denom rat) d))
  (check-rat (make-rat 1 3) 1 3)
  (check-rat (make-rat -2 4) -1 2)
  (check-rat (make-rat 3 -6) -1 2)
  (check-rat (make-rat -4 -8) 1 2))

