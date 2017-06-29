#lang racket

;; Exercise 2.48 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e48

(require "ex2.46.rkt")

(define (make-segment v1 v2)
  (cons v1 v2))
(define (start-segemnt s)
  (car s))
(define (end-segemnt s)
  (cdr s))

