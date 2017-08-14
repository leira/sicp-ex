#lang racket

;; Exercise 2.41 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e41

(require "ex2.40.rkt")

;; generate unique tuples of size `size`, 1 <= i[0] < i[1] < ... < i[size-1] < n
(define (unique-tuples size n)
  (if (< size 1)
      (list null)
      (flatmap
        (λ (i)
           (map (λ (t) (cons i t))
                (unique-tuples (- size 1) i)))
        (range 1 n))))
(module+ test
  (require rackunit)
  (check-equal? (unique-tuples 1 1) '())
  (check-equal? (unique-tuples 1 2) '((1)))
  (check-equal? (unique-tuples 1 3) '((1) (2)))
  (check-equal? (unique-tuples 2 2) '())
  (check-equal? (unique-tuples 2 3) '((2 1)))
  (check-equal? (unique-tuples 2 5) '((2 1) (3 1) (3 2) (4 1) (4 2) (4 3)))
  (check-equal? (unique-tuples 3 3) '())
  (check-equal? (unique-tuples 3 4) '((3 2 1)))
  (check-equal? (unique-tuples 3 6) '((3 2 1)
                                      (4 2 1)
                                      (4 3 1)
                                      (4 3 2)
                                      (5 2 1)
                                      (5 3 1)
                                      (5 3 2)
                                      (5 4 1)
                                      (5 4 2)
                                      (5 4 3))))


(define (sum-s-triples n s)
  (filter 
    (λ (t) (= (foldr + 0 t) s))
    (unique-tuples 3 (+ n 1))))
(module+ test
  (check-equal? (sum-s-triples 5 9) '((4 3 2) (5 3 1)))
  (check-equal? (sum-s-triples 6 10) '((5 3 2) (5 4 1) (6 3 1))))

