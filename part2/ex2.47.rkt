#lang racket

;; Exercise 2.47 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e47

(require "ex2.46.rkt")

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (cadr f))
(define (edge2-frame f)
  (caddr f))

(define (make-frame-p origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame-p f)
  (car f))
(define (edge1-frame-p f)
  (cadr f))
(define (edge2-frame-p f)
  (cddr f))

