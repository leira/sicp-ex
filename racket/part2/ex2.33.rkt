#lang racket/base

;; Exercise 2.33: Fill in the missing expressions to complete the following
;; definitions of some basic list-manipulation operations as accumulations:
;;
;; (define (map p sequence)
;;   (accumulate (lambda (x y) ⟨??⟩) 
;;               nil sequence))
;; 
;; (define (append seq1 seq2)
;;   (accumulate cons ⟨??⟩ ⟨??⟩))
;; 
;; (define (length sequence)
;;   (accumulate ⟨??⟩ 0 sequence))
;; 

(define accumulate foldr)

(define (map p sequence)
  (accumulate (lambda (i r) (cons (p i) r)) 
              '() sequence))
(module+ test
  (require rackunit)
  (check-equal? (map (lambda (x) (* x x))
                     (list 1 2 3 4))
                (list 1 4 9 16)))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(module+ test
  (check-equal? (append (list 1 2 3 4)
                        (list 5 6 7 8))
                (list 1 2 3 4 5 6 7 8)))

(define (length sequence)
  (accumulate (lambda (i r) (+ 1 r))
              0
              sequence))
(module+ test
  (check-equal? (length (list 1 2 3 4)) 4))

