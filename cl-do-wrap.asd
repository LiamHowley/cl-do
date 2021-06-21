(defsystem #:cl-do-wrap
    :description "Wrapper to digital ocean api"
    :depends-on ("drakma" "yason")
    :components ((:file "package")
		 (:file "droplet")))
