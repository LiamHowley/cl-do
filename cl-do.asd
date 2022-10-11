(defsystem #:cl-do
    :description "Wrapper to digital ocean api"
    :depends-on ("drakma"
		 "alexandria"
		 "flexi-streams"
		 "yason"
		 "fare-memoization")
    :components ((:file "package")
		 (:file "request")
		 (:file "account")
		 (:file "image")
		 (:file "snapshot")
		 (:file "droplet")
		 (:file "vpc")))
