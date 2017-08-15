;; Exercise 2.68 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e68

(ns sicp.part2.ex68
  (:require [clojure.test :refer :all]
            [sicp.part2.huffman :refer :all]))

(defn encode-symbol [symbol branch]
  (if (leaf? branch)
      '()
      (letfn [(encode-branch [pick-branch bit]
                (if (contains? (symbols (pick-branch branch)) symbol)
                    (cons bit (encode-symbol symbol (pick-branch branch)))
                    false))]
        (or (encode-branch left-branch 0)
            (encode-branch right-branch 1)
            (throw (Exception. "bad symbol: ENCODE-SYMBOL" symbol))))))

(defn encode [message tree]
  (if (empty? message)
      '()
      (concat 
        (encode-symbol (first message) 
                       tree)
        (encode (rest message) tree))))

(deftest encode-sample
  (let [sample-tree
         (make-code-tree
          (make-leaf 'A 4)
          (make-code-tree
           (make-leaf 'B 2)
           (make-code-tree 
            (make-leaf 'D 1)
            (make-leaf 'C 1))))
        sample-message
          '(A D     A B   B   C     A)]
  (is (=  '(0 1 1 0 0 1 0 1 0 1 1 1 0) (encode sample-message sample-tree)))))
