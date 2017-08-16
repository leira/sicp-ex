;; Exercise 2.70 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e70

(ns sicp.part2.ex70
  (:require [clojure.test :refer :all]
            [sicp.part2.huffman :refer :all]
            [sicp.part2.ex68 :refer :all]
            [sicp.part2.ex69 :refer :all]))

(deftest encode-rock
  (let [syms '[[A    2] [NA  16]
               [BOOM 1] [SHA  3]
               [GET  2] [YIP  9]
               [JOB  2] [WAH  1]]
        lyrics '[GET A JOB
                 SHA NA NA NA NA NA NA NA NA

                 GET A JOB
                 SHA NA NA NA NA NA NA NA NA

                 WAH YIP YIP YIP YIP 
                 YIP YIP YIP YIP YIP
                 SHA BOOM]
        tree (generate-huffman-tree syms)]
    (is (= 84 (count (encode lyrics tree))))))
; fixed length code will need 108 bits

