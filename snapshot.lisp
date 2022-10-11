(in-package :cl-do)

(defun list-snapshots (&optional parameters)
  "Lists all snapshots. Can be filtered by specifying parameters in (key value) pairs: 
(\"resource_type\" \"droplet\"), (\"resource_type\" \"volume\"), 
(\"page\" 1), (\"per_page\" 20) or (\"tag_name\" \"<tag-name>\")."
  (request #'get-request (uri :category "droplets" :parameters parameters)))

(defun retrieve-snapshot (snapshot-id)
  "Retrieves an existing snapshot."
  (request #'get-request (uri :category "snapshot" :identifier snapshot-id)))

(defun delete-snapshot (snapshot-id)
  "Deletes an existing droplet."
  (request #'delete-request (uri :category "snapshot" :identifier snapshot-id)))
