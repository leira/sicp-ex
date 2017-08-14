#lang racket

;; Exercise 2.62 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e62

(provide union-set)
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (union-set
                                  (cdr set1)
                                  (cdr set2))))
                      ((< x1 x2)
                       (cons x1 (union-set
                                  (cdr set1) 
                                  set2)))
                      ((< x2 x1)
                       (cons x2 (union-set
                                  set1 
                                  (cdr set2)))))))))
(module+ test
  (require rackunit)
  (check-equal? (union-set '(1 2 3 4)
                           '(1 4 5 6))
                '(1 2 3 4 5 6))
  (check-equal? (union-set '()
                           '(1 4 5 6))
                '(1 4 5 6))
  (check-equal? (union-set '(1 2 3 4)
                           '())
                '(1 2 3 4))
  )
  
(provide intersection-set)
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set 
                         (cdr set1)
                         (cdr set2))))
              ((< x1 x2) (intersection-set 
                          (cdr set1) 
                          set2))
              ((< x2 x1) (intersection-set 
                          set1 
                          (cdr set2)))))))
