;; Auto-generated. Do not edit!


(when (boundp 'robots_moviles_package::posicion)
  (if (not (find-package "ROBOTS_MOVILES_PACKAGE"))
    (make-package "ROBOTS_MOVILES_PACKAGE"))
  (shadow 'posicion (find-package "ROBOTS_MOVILES_PACKAGE")))
(unless (find-package "ROBOTS_MOVILES_PACKAGE::POSICION")
  (make-package "ROBOTS_MOVILES_PACKAGE::POSICION"))
(unless (find-package "ROBOTS_MOVILES_PACKAGE::POSICIONREQUEST")
  (make-package "ROBOTS_MOVILES_PACKAGE::POSICIONREQUEST"))
(unless (find-package "ROBOTS_MOVILES_PACKAGE::POSICIONRESPONSE")
  (make-package "ROBOTS_MOVILES_PACKAGE::POSICIONRESPONSE"))

(in-package "ROS")





(defclass robots_moviles_package::posicionRequest
  :super ros::object
  :slots (_direccion ))

(defmethod robots_moviles_package::posicionRequest
  (:init
   (&key
    ((:direccion __direccion) 0)
    )
   (send-super :init)
   (setq _direccion (round __direccion))
   self)
  (:direccion
   (&optional __direccion)
   (if __direccion (setq _direccion __direccion)) _direccion)
  (:serialization-length
   ()
   (+
    ;; uint8 _direccion
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _direccion
       (write-byte _direccion s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _direccion
     (setq _direccion (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass robots_moviles_package::posicionResponse
  :super ros::object
  :slots (_resultado ))

(defmethod robots_moviles_package::posicionResponse
  (:init
   (&key
    ((:resultado __resultado) 0)
    )
   (send-super :init)
   (setq _resultado (round __resultado))
   self)
  (:resultado
   (&optional __resultado)
   (if __resultado (setq _resultado __resultado)) _resultado)
  (:serialization-length
   ()
   (+
    ;; uint8 _resultado
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _resultado
       (write-byte _resultado s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _resultado
     (setq _resultado (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass robots_moviles_package::posicion
  :super ros::object
  :slots ())

(setf (get robots_moviles_package::posicion :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get robots_moviles_package::posicion :datatype-) "robots_moviles_package/posicion")
(setf (get robots_moviles_package::posicion :request) robots_moviles_package::posicionRequest)
(setf (get robots_moviles_package::posicion :response) robots_moviles_package::posicionResponse)

(defmethod robots_moviles_package::posicionRequest
  (:response () (instance robots_moviles_package::posicionResponse :init)))

(setf (get robots_moviles_package::posicionRequest :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get robots_moviles_package::posicionRequest :datatype-) "robots_moviles_package/posicionRequest")
(setf (get robots_moviles_package::posicionRequest :definition-)
      "uint8 direccion
---
uint8 resultado

")

(setf (get robots_moviles_package::posicionResponse :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get robots_moviles_package::posicionResponse :datatype-) "robots_moviles_package/posicionResponse")
(setf (get robots_moviles_package::posicionResponse :definition-)
      "uint8 direccion
---
uint8 resultado

")



(provide :robots_moviles_package/posicion "049d75b744ba6418566a32f18f43c69c")


