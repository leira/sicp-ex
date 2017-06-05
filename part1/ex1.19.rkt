#lang racket/base

;; Exercise 1.19: There is a clever algorithm for computing the Fibonacci
;; numbers in a logarithmic number of steps. Recall the transformation of the
;; state variables aa and bb in the fib-iter process of 1.2.2: $a \gets a+b$
;; and $b \gets a$. Call this transformation T, and observe that applying T
;; over and over again n times, starting with 1 and 0, produces the pair
;; Fib(n+1) and Fib(n). In other words, the Fibonacci numbers are produced by
;; applying $T^n$, the $n^{th}$ power of the transformation T, starting with the
;; pair (1, 0). Now consider T to be the special case of p=0 and q=1 in a
;; family of transformations $T_{pq}$, where $T_{pq}$ transforms the pair (a,b)
;; according to $a \gets bq+aq+ap$ and $b \gets bp+aq$. Show that if we apply
;; such a transformation $T_{pq}$ twice, the effect is the same as using a
;; single transformation $T_{p'q'}$ of the same form, and compute p' and q' in
;; terms of p and q. This gives us an explicit way to square these
;; transformations, and thus we can compute TnTn using successive squaring, as
;; in the fast-expt procedure. Put this all together to complete the following
;; procedure, which runs in a logarithmic number of steps:

;; $$\begin{align}
;; T_{pq}:\\
;; a & \gets bq + aq + ap \\
;; b & \gets bp + aq \\[2ex]
;;  
;; a' & = bq + aq + ap \\
;; b' & = bp + aq \\[2ex]
;; 
;; a'' & = b'q + a'q + a'p \\
;;     & = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p \\
;;     & = bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2 \\
;;     & = b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2) \\[2ex]
;; 
;; b'' & = b'p + a'q \\
;;     & = (bp + aq)p + (bq + aq + ap)q \\ 
;;     & = bp^2 + apq + bq^2 + aq^2 + apq \\
;;     & = b(p^2 + q^2) + a(2pq + q^2) \\[2ex]
;; 
;; let: \\
;; p' & = p^2 + q^2 \\
;; q' & = 2pq + q^2 \\[2ex]
;; 
;; Then:\\
;; T_{p'q'} & = T_{pq}^2
;; \end{align}$$

(require "part1-helpers.rkt")

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p)
                      (square q))
                   (+ (* 2 p q)
                      (square q))
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))

(module+ test
  (require rackunit)
  (check-equal? (fib 0) 0)
  (check-equal? (fib 1) 1)
  (check-equal? (fib 2) 1)
  (check-equal? (fib 5) 5)
  (check-equal? (fib 10) 55)
  (check-equal? (fib 15) 610))

