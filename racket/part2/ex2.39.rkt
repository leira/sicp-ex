#lang racket

;; Exercise 2.39 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e39

;; SICP's fold-left is different from Racket's foldl, on the order of arguments
;; when applying function op
;; Racket's foldl is equivalent to:
;;
;; (define (foldl op initial sequence)
;;   (define (iter result rest)
;;     (if (null? rest)
;;         result
;;         (iter (op (car rest) result) ;<- difference here
;;               (cdr rest))))
;;   (iter initial sequence))
;;
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse-r sequence)
  (foldr
   (lambda (x y) (append y (list x))) null sequence))

(define (reverse sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))

(module+ test
  (require rackunit)
  (check-equal? (reverse-r (list 1 2 3 4)) (list 4 3 2 1))
  (check-equal? (reverse (list 1 2 3 4)) (list 4 3 2 1)))

