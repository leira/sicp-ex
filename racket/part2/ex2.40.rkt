#lang racket

;; Exercise 2.40 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e40

(provide flatmap)
(define (flatmap proc seq)
  (foldr append null (map proc seq)))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j)
             (list i j))
           (range 1 i)))
    (range 1 (+ n 1))))
(module+ test
  (require rackunit)
  (check-equal? (unique-pairs 1) '())
  (check-equal? (unique-pairs 2) '((2 1)))
  (check-equal? (unique-pairs 4) '((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))))

;; (define (prime-sum-pairs n)
;;   (map make-pair-sum
;;        (filter 
;;          prime-sum?
;;          (unique-pairs n))))

