#lang racket

;; Exercise 2.32 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e32

(define (subsets s)
  (if (null? s)
      (list s)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (λ (set) (cons (car s) set))
                     rest)))))

(module+ test
  (require rackunit)
  (check-equal? (subsets '(1 2 3))
                '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))))

