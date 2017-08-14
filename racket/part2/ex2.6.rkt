#lang racket

;; Exercise 2.6 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e6

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; one = (add-1 zero)
;;     = (λ (f) (λ (x) (f ((zero f) x))))
;;     = (λ (f) (λ (x) (f ((λ (x) x) x))))
;;     = (λ (f) (λ (x) (f x)))
(define one (λ (f) (λ (x) (f x))))

;; two  = (add-1 one)
;;      = (λ (f) (λ (x) (f ((one f) x))))
;;      = (λ (f) (λ (x) (f ((λ (x) (f x)) x))))
;;      = (λ (f) (λ (x) (f (f x))))
(define two (λ (f) (λ (x) (f (f x)))))

;; three = (add-1 two)
;;       = (λ (f) (λ (x) (f ((two f) x))))
;;       = (λ (f) (λ (x) (f ((λ (x) (f (f x))) x))))
;;       = (λ (f) (λ (x) (f (f (f x)))))
(define three (λ (f) (λ (x) (f (f (f x))))))

;; two = (+ one one)
;; (one f) = (λ (x) (f x))
;; ((one f) x) = (f x)
;; 
;; ((one f) ((one f) x)) = ((λ (x) (f x)) (f x))
;;                   = (f (f x))

(define (+ a b)
  (λ (f) (λ (x) ((a f) ((b f) x)))))

;; two = (+ one one)
;;     = (λ (f) (λ (x) ((one f) ((one f) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f x)) ((λ (x) (f x)) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f x)) (f x))))
;;     = (λ (f) (λ (x) (f (f x))))
;; 
;; three = (+ one two)
;;     = (λ (f) (λ (x) ((one f) ((two f) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f x)) ((λ (x) (f (f x))) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f x)) (f (f x)))))
;;     = (λ (f) (λ (x) (f (f (f x)))))
;; 
;; three = (+ two one)
;;     = (λ (f) (λ (x) ((two f) ((one f) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f (f x))) ((λ (x) (f x)) x))))
;;     = (λ (f) (λ (x) ((λ (x) (f (f x))) (f x))))
;;     = (λ (f) (λ (x) (f (f (f x)))))

