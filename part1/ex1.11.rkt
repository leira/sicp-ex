#lang racket/base

;; Exercise 1.11: A function ff is defined by the rule that f(n)=n if n<3 and
;; f(n)=f(n−1)+2f(n−2)+3f(n−3) if n≥3.
;; Write a procedure that computes f by means of a recursive process. Write a
;; procedure that computes f by means of an iterative process.

(define (f-recur n)
  (if (< n 3) 
      n
      (+ (f-recur (- n 1))
         (* 2 (f-recur (- n 2)))
         (* 3 (f-recur (- n 3))))))

(module+ test
  (require rackunit)
  (check-equal? (f-recur 0) 0)
  (check-equal? (f-recur 2) 2)
  (check-equal? (f-recur 3) 4)
  (check-equal? (f-recur 6) 59))

(define (f n)
  (define (f-iter a b c count)
    (if (< count 3) 
        a
        (f-iter (+ a (* 2 b) (* 3 c))
                a b (- count 1))))
  (if (< n 3)
      n
      (f-iter 2 1 0 n)))

(module+ test
  (check-equal? (f 0) 0)
  (check-equal? (f 2) 2)
  (check-equal? (f 3) 4)
  (check-equal? (f 6) 59))

