#lang racket

;; Exercise 2.27 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e27

(define (deep-reverse l)
  (define (rev result items)
    (if (null? items)
        result
        (rev (cons (deep-reverse (car items))
                   result)
             (cdr items))))
  (if (not (list? l))
      l
      (rev null l)))

(module+ test
  (require rackunit)
  (check-equal? (deep-reverse 1) 1)
  (check-equal? (deep-reverse '()) '())
  (check-equal? (deep-reverse '(1)) '(1))
  (check-equal? (deep-reverse '((1))) '((1)))
  (check-equal? (deep-reverse '((1 2))) '((2 1)))
  (check-equal? (deep-reverse '((1 2) (3 4))) '((4 3) (2 1))))

