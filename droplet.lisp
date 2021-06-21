(in-package :cl-do)


(defun list-all-droplets ()
  (let ((response
	 (get-request "https://api.digitalocean.com/v2/droplets"))
	(*parse-json-arrays-as-vectors* t))
	;;(*parse-object-as* :plist))
    (parse-response response)))


(defun list-droplets-by-tag (tagname)
  (let ((response
	 (get-request (uri (concatenate 'string "https://api.digitalocean.com/v2/droplets?tag_name=" tagname))))
	(*parse-json-arrays-as-vectors* t))
	;;(*parse-object-as* :plist))
    (parse-response response)))


(defun create-droplet (&rest params &key name region size image ssh-keys backups ipv6 user-data vpc-uuid user-data monitoring volumes tags)
  )
