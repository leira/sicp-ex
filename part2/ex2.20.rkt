#lang racket

;; Exercise 2.20 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e20

(define (same-parity first . rest)
  (define (sp l p result)
    (if (null? l)
        result
        (let ((head (car l))
              (rest (cdr l)))
          (if (= (remainder head 2) p)
              (sp rest p (cons head result))
              (sp rest p result)))))
  (let ((p (remainder first 2)))
    (reverse (sp rest p (list first)))))

(module+ test
  (require rackunit)
  (check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))
  (check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6)))

