#lang racket

;; Exercise 2.3 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e3

(require "ex2.2.rkt")

;; rectangle defined by base and height segments
(define (make-rectangle b-seg h-seg)
  (cons b-seg h-seg))
(define (base-seg rect)
  (car rect))
(define (height-seg rect)
  (cdr rect))
  
(define (base rect)
  (length-segment (base-seg rect)))
(define (height rect)
  (length-segment (height-seg rect)))

(define (perimeter rect)
  (* (+ (base rect)
        (height rect))
     2))
     
(define (area rect)
  (* (base rect)
     (height rect)))
     
(module+ test
  (require rackunit)
  (define tolerance 0.00001)
  (define unit-rect
    (make-rectangle (make-segment (make-point 0 0)
                                  (make-point 1 0))
                    (make-segment (make-point 0 0)
                                  (make-point 0 1))))
  (define s-rect
    (make-rectangle (make-segment (make-point 1 0)
                                  (make-point 3 2))
                    (make-segment (make-point 1 0)
                                  (make-point 0 1))))
  (define (check-rects unit-rect s-rect)
    (check-equal? (perimeter unit-rect) 4)
    (check-equal? (area unit-rect) 1)
    (check-= (perimeter s-rect) (* 6 (sqrt 2)) tolerance)
    (check-= (area s-rect) 4 tolerance))
  (check-rects unit-rect s-rect))


;; Alternative implementation, rectangle is defined by 3 points
;; (define (make-rectangle start-point base-point height-point)
;;   (cons start-point (cons base-point height-point)))
;; (define (start-point rect)
;;   (car rect))
;; (define (base-point rect)
;;   (cadr rect))
;; (define (height-point rect)
;;   (cddr rect))
;; (define (base-seg rect)
;;   (make-point (start-point rect)
;;               (base-point rect)))
;; (define (height-seg rect)
;;   (make-point (start-point rect)
;;               (height-point rect)))
;; 
;; (module+ test
;;   (define unit-rect
;;     (make-rectangle (make-point 0 0)
;;                     (make-point 1 0)
;;                     (make-point 0 1)))
;;   (define s-rect
;;     (make-rectangle (make-point 1 0)
;;                     (make-point 3 2)
;;                     (make-point 0 1)))
;;   (check-rects unit-rect s-rect))

