(in-package :cl-do)


(defun list-droplets (&optional parameters)
  "Lists all droplets. Can be filtered by specifying parameters in (key value) pairs: 
(\"type\" \"distribution\"), (\"type\" \"application\"), 
(\"page\" 1), (\"per_page\" 20) or (\"tag_name\" \"<tag-name>\")."
  (request #'get-request (uri :category "droplets" :parameters parameters)))

(defun create-droplet (&rest droplet-params &key name region size image ssh-keys backups ipv6 vpc-uuid user-data monitoring volumes tags)
  "Name, region, size, and image are required. Defaults are false, 
or empty arrays in the case of ssh-keys and tags."
  (declare (ignore name region size image ssh-keys backups ipv6 vpc-uuid user-data monitoring volumes tags))
  (request #'post-request (uri :category "droplets") (encode-plist droplet-params)))

(defun create-multiple-droplets (&rest droplet-params &key names region size image ssh-keys backups ipv6 vpc-uuid user-data monitoring volumes tags)
  (declare (ignore names region size image ssh-keys backups ipv6 vpc-uuid user-data monitoring volumes tags))
  "Creating multiple droplets is very similar to creating a droplet, 
but that the name keyword is replaced with names, requiring either a 
list or array of names. Up to 10 droplets can be created at a time."
  (request #'post-request (uri :category "droplets") (encode-plist droplet-params)))

(defun delete-droplets-by-tag (tag-name)
  (request #'delete-request (uri :category "droplets") (encode-plist droplet-params)))

(defun retrieve-droplet (droplet-id)
  "Retrieves an existing droplet."
  (request #'get-request (uri :category "droplets" :identifier droplet-id)))

(defun delete-droplet (droplet-id)
  "Deletes an existing droplet."
  (request #'delete-request (uri :category "droplets" :identifier droplet-id)))

(defmacro def-list-droplet (name keys)
  "Defines/returns a function that returns a list of droplet associated objects."
  `(defun ,name (droplet-id &optional parameters)
     ,(format nil "Lists all ~a for specified droplet. Can be filtered by specifying 
parameters in (key value) pairs: (\"page\" 1), (\"per_page\" 20)." keys)
     (request #'get-request (uri :category "droplets" :identifier droplet-id :keys ,keys :parameters parameters))))

(def-list-droplet list-backups-for-a-droplet "backups")
(def-list-droplet list-snapshots-for-a-droplet "snapshots")
(def-list-droplet list-kernels-for-a-droplet "kernels")
(def-list-droplet list-firewalls-for-a-droplet "firewalls")
(def-list-droplet list-neightbours-for-a-droplet "neighbours")
(def-list-droplet list-associated-resources-for-a-droplet "destroy_with_associated_resources")


(defun delete-droplet-and-resources (droplet-id associated-resources)
  "Deletes an existing droplet and associated resources. Associated resources is a plist
parsed from list-associated-resources-for-a-droplet."
  ;; using post-request to facilitate content: method manually set to "delete"
  (request #'post-request (uri :category "droplets"
				 :identifier droplet-id
				 :keys '("destroy_with_associated_resources" "selective"))
	   :method
	   (encode-plist associated-resources)))

(defun destroyed-droplet-status (droplet-id)
  "Checks if a droplet and associated resources has been deleted."
  (request #'delete-request (uri :category "droplets"
				 :identifier droplet-id
				 :keys '("destroy_with_associated_resources" "status"))))

(defun retry-droplet-destroy (droplet-id)
  "Checks if a droplet and associated resources has been deleted."
  (request #'post-request (uri :category "droplets"
				 :identifier droplet-id
				 :keys '("destroy_with_associated_resources" "retry"))))

(defun purge-droplet (droplet-id)
  "*** Deletes an existing droplet and associated resources.
 Destructive and cannot be reversed. ***"
  (request #'delete-request (uri :category "droplets"
				 :identifier droplet-id
				 :keys '("destroy_with_associated_resources" "dangerous")
				 :headers '(("X-Dangerous" . "true")))))

(defun droplet-neighbours ()
  "Retrieve a list of all droplets that are co-located 
on the same physical hardware"
  (request #'get-request (uri :keys '("reports" "droplet_neighbors_ids"))))
