(def project 'sicp)
(def version "0.1.0-SNAPSHOT")

(set-env! :resource-paths #{"src"}
          :dependencies   '[[org.clojure/clojure "1.8.0"]
                            [adzerk/boot-test "RELEASE" :scope "test"]])

(require '[adzerk.boot-test :refer [test]])
