#lang racket

;; Exercise 1.45: We saw in 1.3.3 that attempting to compute square roots by
;; naively finding a fixed point of $y \mapsto x/y$ does not converge, and that
;; this can be fixed by average damping. The same method works for finding cube
;; roots as fixed points of the average-damped $y \mapsto x/y^2$. Unfortunately,
;; the process does not work for fourth roots—a single average damp is not
;; enough to make a fixed-point search for $y \mapsto x/y^3$ converge. On the
;; other hand, if we average damp twice (i.e., use the average damp of the
;; average damp of $y \mapsto x/y^3$) the fixed-point search does converge. Do
;; some experiments to determine how many average damps are required to compute
;; $n^{th} roots as a fixed-point search based upon repeated average damping of
;; $y \mapsto x/y^{n−1}$. Use this to implement a simple procedure for
;; computing $n^{th} roots using fixed-point, average-damp, and the repeated
;; procedure of Exercise 1.43. Assume that any arithmetic operations you need
;; are available as primitives.

;; To compute $n^{th}$ root, a $\log_2 n$ times average damping is needed.
;; I couldn't find any explanation or proof in English, but I did find these
;; two article in Chinese:
;; https://zhuanlan.zhihu.com/p/25601871
;; https://www.zhihu.com/question/28838814

(require "part1-helpers.rkt")
(require "ex1.16.rkt")
(require "ex1.43.rkt")

(define tolerance 0.00001)

(define (nth-root n x)
  (define damp-level (floor (log2 n)))
  (define damp (repeated average-damp damp-level))
  (define (iter-func y)
    (/ x (fast-expt y (- n 1))))
  (fixed-point (damp iter-func) 1.0 tolerance))

(define (log2 x)
  (/ (log x) (log 2)))
  
(module+ test
  (require rackunit)
  (check-= (nth-root 2 2) 1.41421356237 tolerance)
  (check-= (nth-root 3 2) 1.25992104989 tolerance)
  (check-= (nth-root 4 2) 1.189207115 tolerance)
  (check-= (nth-root 5 2) 1.148698355 tolerance)
  (check-= (nth-root 8 2) 1.09050773267 tolerance))

