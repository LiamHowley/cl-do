(defpackage :cl-do
  (:use :cl)
  (:import-from :drakma
		:http-request)
  (:import-from :yason
		:parse
		:*parse-object-as*
		:*parse-object-key-fn*
		:*symbol-key-encoder*)
  (:export :list-droplets
	   :create-droplet
	   :create-multiple-droplets
	   :delete-droplet-by-tag
	   :retrieve-droplet
	   :delete-droplet
	   :list-backups-for-a-droplet
	   :list-snapshots-for-a-droplet
	   :list-kernels-for-a-droplet
	   :list-firewalls-for-a-droplet
	   :list-neighbours-for-a-droplet
	   :list-associated-resources-for-a-droplet
	   :delete-droplet-and-resources
	   :destroyed-droplet-status
	   :retry-droplet-destroy
	   :purge-droplet
	   :droplet-neighbours

	   ;;images
	   :list-images
	   :create-custom-image
	   :retrieve-image
	   :update-image
	   :delete-image

	   ))


(in-package :cl-do)

(defparameter *auth-token*
  (concatenate 'string "Bearer " 
	       (with-open-file (stream #P "~/do" :direction :input) 
		 (let ((seq (make-array (file-length stream) :element-type 'character)))
		   (read-sequence seq stream)
		   seq))))

(defparameter *base-uri* "https://api.digitalocean.com/v2/")
