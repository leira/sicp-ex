#lang racket

;; Exercise 2.58 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e58

;; 1. (x + (3 * (x + (y + 2))))
(define (sum? x)
  (and (list? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s) (caddr s))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define (product? x)
  (and (list? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list m1 '* m2))))

(module+ test
  (require rackunit)
  (check-equal? (deriv '(5 + x) 'x) 1)
  (check-equal? (deriv '(y * x) 'x) 'y)
  (check-equal? (deriv '(x + (3 * (x + (y + 2)))) 'x) 4)
  (check-equal? (deriv '((x * y) * (x + 3)) 'x) '((x * y) + (y * (x + 3)))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
          (if (same-variable? exp var) 1 0))
        ((sum? exp)
          (make-sum (deriv (addend exp) var)
                    (deriv (augend exp) var)))
        ((product? exp)
          (make-sum
            (make-product
              (multiplier exp)
              (deriv (multiplicand exp) var))
            (make-product 
              (deriv (multiplier exp) var)
              (multiplicand exp))))
        (else (error "unknown expression 
                      type: DERIV" exp))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(provide =number?)
(define (=number? exp num)
  (and (number? exp) (= exp num)))

