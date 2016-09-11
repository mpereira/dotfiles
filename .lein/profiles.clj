{:user {:plugins
        [[cider/cider-nrepl "0.13.0" :exclusions [org.clojure/clojure]]
         [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
         [io.aviso/pretty "0.1.30" :exclusions [org.clojure/clojure]]
         [lein-ancient "0.6.10" :exclusions [org.clojure/clojure]]
         [lein-cljfmt "0.5.3" :exclusions [org.clojure/clojure]]
         [lein-exec "0.3.6" :exclusions [org.clojure/clojure]]
         [lein-grep "0.1.1" :exclusions [org.clojure/clojure]]
         [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]
         [lein-nodisassemble "0.1.3" :exclusions [org.clojure/clojure]]
         [lein-vanity "0.2.0" :exclusions [org.clojure/clojure]]]
        :dependencies
        [[cljfmt "0.5.3" :exclusions [org.clojure/clojure]]
         [criterium "0.4.4" :exclusions [org.clojure/clojure]]
         [im.chit/vinyasa "0.4.7" :exclusions [org.clojure/clojure]]
         [io.aviso/pretty "0.1.30" :exclusions [org.clojure/clojure]]
         [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
         [org.clojars.gjahad/debug-repl "0.3.3"
          :exclusions [org.clojure/clojure]]
         [org.clojure/clojure "1.8.0"]
         [org.clojure/tools.namespace "0.2.10"
          :exclusions [org.clojure/clojure]]
         [org.clojure/tools.trace "0.7.9" :exclusions [org.clojure/clojure]]
         [pjstadig/humane-test-output "0.8.1" :exclusions [org.clojure/clojure]]
         [slamhound "1.5.5" :exclusions [org.clojure/clojure]]
         [spyscope "0.1.5" :exclusions [org.clojure/clojure]]]
        :injections
        [(require 'alex-and-georges.debug-repl)
         (require 'clojure.repl
                  'io.aviso.repl)
         (require 'pjstadig.humane-test-output)
         (require 'spyscope.core)
         (require 'vinyasa.inject)
         (pjstadig.humane-test-output/activate!)
         (vinyasa.inject/in [vinyasa.maven pull]

                            [clojure.tools.namespace.repl refresh refresh-all]

                            clojure.core
                            [alex-and-georges.debug-repl debug-repl]

                            clojure.core
                            [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                            clojure.core >
                            [clojure.repl doc source]
                            [clojure.pprint pprint pp])]
        :repl-options {:init (do
                               (load-file (str (System/getProperty "user.home")
                                               "/.lein/user.clj"))) }
        :eastwood {:all true}}}
