#lang racket

;; Exercise 2.42 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e42

(require "ex2.40.rkt")

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions)
            (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position 
                       new-row
                       k
                       rest-of-queens))
                   (range 1 
                          (+ board-size 1))))
            (queen-cols (- k 1))))))
  (queen-cols board-size))
(module+ test
  (require rackunit)
  (check-equal? (queens 4) (list (list (make-queen 3 4)
                                       (make-queen 1 3)
                                       (make-queen 4 2)
                                       (make-queen 2 1))
                                 (list (make-queen 2 4)
                                       (make-queen 4 3)
                                       (make-queen 1 2)
                                       (make-queen 3 1))))
  (check-equal? (length (queens 8)) 92))

(define (adjoin-position row col rest-of-queens)
        (cons (make-queen row col) rest-of-queens))

(define empty-board null)

(define (safe? current-row positions) ; current-row not used
  (let ((cur-q (car positions))
        (rest-qs (cdr positions)))
    (andmap (λ (q) (not (attack? cur-q q)))
            rest-qs)))
(module+ test
  (check-true (safe? 4 (list (make-queen 3 4)
                             (make-queen 1 3)
                             (make-queen 4 2)
                             (make-queen 2 1))))
  (check-false (safe? 4 (list (make-queen 2 4)
                              (make-queen 1 3)
                              (make-queen 4 2)
                              (make-queen 2 1)))))

(define (attack? q1 q2)
  (or (= (row-queen q1)
         (row-queen q2))
      (= (col-queen q1)
         (col-queen q2))
      (= (+ (row-queen q1)
            (col-queen q1))
         (+ (row-queen q2)
            (col-queen q2)))
      (= (- (row-queen q1)
            (col-queen q1))
         (- (row-queen q2)
            (col-queen q2)))))
(module+ test
  (check-true (attack? (make-queen 1 2)
                       (make-queen 1 5)))
  (check-true (attack? (make-queen 1 2)
                       (make-queen 5 2)))
  (check-true (attack? (make-queen 1 2)
                       (make-queen 3 4)))
  (check-true (attack? (make-queen 4 2)
                       (make-queen 1 5))))

(define (make-queen row col)
  (cons row col))
(define (row-queen q)
  (car q))
(define (col-queen q)
  (cdr q))

