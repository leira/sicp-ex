#lang racket/base

;; Exercise 2.35: Redefine count-leaves from 2.2.2 as an accumulation:
;; 
;; (define (count-leaves t)
;;   (accumulate ⟨??⟩ ⟨??⟩ (map ⟨??⟩ ⟨??⟩)))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append 
               (enumerate-tree (car tree))
               (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (foldr + 0 (map (lambda (x) 1) (enumerate-tree t))))

(module+ test
  (require rackunit)
  (check-equal? (count-leaves 
                  (cons (list 1 2) (list 3 4)))
                4))

