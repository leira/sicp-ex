#lang racket

;; Exercise 2.29 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e29

;; list implementation
; (define (make-mobile left right)
;   (list left right))
; (define (left-branch mobile)
;   (car mobile))
; (define (right-branch mobile)
;   (cadr mobile))
; 
; (define (make-branch length structure)
;   (list length structure))
; (define (branch-length branch)
;   (car branch))
; (define (branch-structure branch)
;   (cadr branch))
(define (structure-mobile? s)
  (pair? s))

;; pair implementation
(define (make-mobile left right)
  (cons left right))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))

(define (make-branch length structure)
  (cons length structure))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))
  
(define (branch-weight branch)
  (let ((s (branch-structure branch)))
    (if (not (structure-mobile? s))
        s
        (total-weight s))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))


(define (mobile-balanced? mobile)
  (define (branch-torque branch)
    (* (branch-length branch)
       (branch-weight branch)))
  (define (branch-balanced? branch)
    (let ((s (branch-structure branch)))
      (if (not (structure-mobile? s))
          #t
          (mobile-balanced? s))))
  (let ((lb (left-branch mobile))
        (rb (right-branch mobile)))
    (and (branch-balanced? lb)
         (branch-balanced? rb)
         (= (branch-torque lb)
            (branch-torque rb)))))


(module+ test
  (require rackunit)
  (define l1 (make-mobile
               (make-branch 2 1)
               (make-branch 1 2)))
  (define mb
    (make-mobile 
      (make-branch 2 l1)
      (make-branch 2 3)))
  (define mi
    (make-mobile 
      (make-branch 2 l1)
      (make-branch 1 3)))
  (check-equal? (total-weight mb) 6)
  (check-equal? (total-weight mi) 6)
  (check-true (mobile-balanced? mb))
  (check-false (mobile-balanced? mi)))

