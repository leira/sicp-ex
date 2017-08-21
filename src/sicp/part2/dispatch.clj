(ns sicp.part2.dispatch)

(def ^{:private true} op-table (atom {}))

(defn put-op [op type item]
  (swap! op-table (fn [table] (assoc-in table [op type] item))))

(defn get-op [op type]
  (get-in @op-table [op type]))
