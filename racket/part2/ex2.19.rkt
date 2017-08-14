#lang racket

;; Exercise 2.19 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e19

(define (cc amount coin-values)
  (cond ((= amount 0) 
         1)
        ((or (< amount 0) 
             (no-more? coin-values)) 
         0)
        (else
         (+ (cc 
             amount
             (except-first-denomination 
              coin-values))
            (cc 
             (- amount
                (first-denomination 
                 coin-values))
             coin-values)))))

(define (no-more? coins)
  (null? coins))

(define (except-first-denomination coins)
  (cdr coins))

(define (first-denomination coins)
  (car coins))


(module+ test
  (require rackunit)
  (define us-coins 
    (list 50 25 10 5 1))
  (define uk-coins 
    (list 100 50 20 10 5 2 1 0.5))
  (check-equal? (cc 100 us-coins) 292)
  (check-equal? (cc 100 uk-coins) 104561))

