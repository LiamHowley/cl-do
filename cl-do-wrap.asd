(defsystem #:cl-do-wrap
    :description "Wrapper to digital ocean api"
    :depends-on ("drakma" "puri" "yason")
    :components ((:file "package")
		 (:file "droplet")))
