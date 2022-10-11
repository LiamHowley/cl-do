(defsystem #:cl-do-wrap
    :description "Wrapper to digital ocean api"
    :depends-on ("drakma"
		 "flexi-streams"
		 "yason")
    :components ((:file "package")
		 (:file "request"))
		 (:file "image")
		 (:file "droplet")))
