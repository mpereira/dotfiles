{:user {:plugins [[cider/cider-nrepl "0.8.2"]
                  [jonase/eastwood "0.2.1"]
                  [lein-ancient "0.5.5"]
                  [lein-exec "0.3.4"]
                  [lein-grep "0.1.0"]
                  [lein-kibit "0.0.8"]
                  [lein-nodisassemble "0.1.3"]
                  [lein-vanity "0.2.0"]
                  #_[lein-warn-closeable "0.1.0-SNAPSHOT"]]
        :dependencies [[clj-ns-browser "1.3.1"]
                       #_[com.sungpae/warn-closeable "0.1.0-SNAPSHOT"]
                       [criterium "0.4.3"]
                       [im.chit/vinyasa "0.2.2"]
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [org.clojure/tools.namespace "0.2.8"]
                       [org.clojure/tools.trace "0.7.8"]
                       [pjstadig/humane-test-output "0.6.0"]
                       [slamhound "1.5.5"]
                       [spyscope "0.1.5"]]
        :injections [(require 'alex-and-georges.debug-repl)
                     (require 'clj-ns-browser.sdoc)
                     (require 'pjstadig.humane-test-output)
                     (require 'spyscope.core)
                     (require '[vinyasa.inject :as inject])
                     (pjstadig.humane-test-output/activate!)
                     (inject/in [vinyasa.pull :all]

                                clojure.core
                                [alex-and-georges.debug-repl debug-repl]
                                [clj-ns-browser.sdoc sdoc]

                                clojure.core >
                                [clojure.repl doc source]
                                [clojure.pprint pprint pp])]
        :repl-options {:init (do
                               (load-file (str (System/getProperty "user.home")
                                               "/.lein/user.clj"))) }
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :eastwood {:all true}}}
