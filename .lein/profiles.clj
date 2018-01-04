{:user {:jvm-opts ["-Xverify:none"]
        :plugins [[jonase/eastwood "0.2.5"]
                  [lein-ancient "0.6.14" :exclusions [org.clojure/clojure]]
                  [lein-cljfmt "0.5.7" :exclusions [org.clojure/clojure]]
                  [lein-kibit "0.1.6"]
                  [lein-try "0.4.3"]
                  [lein-pprint "1.2.0"]]}
 :repl
 {:plugins [[cider/cider-nrepl "0.16.0-SNAPSHOT"]
            [refactor-nrepl "2.4.0-SNAPSHOT"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}
