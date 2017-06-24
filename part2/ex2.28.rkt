#lang racket

;; Exercise 2.28 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e28

(define (fringe tree)
  (cond ((null? tree)
          null)
        ((not (pair? tree))
          (list tree))
        (else 
          (append (fringe (car tree))
                  (fringe (cdr tree))))))

(module+ test
  (require rackunit)
  (define x 
    (list (list 1 2) (list 3 4)))
  (check-equal? (fringe x) (list 1 2 3 4))
  (check-equal? (fringe (list x x)) (list 1 2 3 4 1 2 3 4)))

