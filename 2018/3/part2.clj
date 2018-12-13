(require '[clojure.string :as str]
         '[clojure.pprint :as ppr]
         '[clojure.set    :as set])

(def input (str/split-lines (str/trim (slurp "input"))))

(defn build-claim [string]
  (zipmap [:id :x :y :w :h](map read-string (re-seq #"\d+" string))))

(defn expand-claim [claim]
  {:id (:id claim) :squares 
    (for [x (range (:x claim) (+ (:x claim) (:w claim)))
          y (range (:y claim) (+ (:y claim) (:h claim)))]
      [x y])})

(defn no-overlap? [claim, expanded-claims]
  (let [sq (set (:squares claim))
        other-claims (remove #{claim} expanded-claims)
        xc-sq (set (apply concat (map :squares other-claims)))]
    (empty? 
      (set/intersection sq xc-sq))))

(defn without-overlapped [expanded-claims]
  (filter
    #(no-overlap? % expanded-claims) expanded-claims))

(let [claims (map build-claim input)
      expanded-claims (map expand-claim claims)
      uniq-claims (without-overlapped expanded-claims)]
  (ppr/pprint (:id (first uniq-claims))))
