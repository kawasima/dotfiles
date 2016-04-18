{:user {:jvm-opts ["-Xverify:none"]
        :plugins [[jonase/eastwood "0.2.3"]
                  [lein-ancient "0.6.8" :exclusions [org.clojure/clojure]]
                  [lein-cljfmt "0.4.1" :exclusions [org.clojure/clojure]]
                  [lein-kibit "0.1.2"]
                  [lein-try "0.4.3"]
                  [lein-pprint "1.1.2"]]}
 :repl
 {:plugins [[cider/cider-nrepl "0.11.0"]
            [refactor-nrepl "2.2.0"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}
