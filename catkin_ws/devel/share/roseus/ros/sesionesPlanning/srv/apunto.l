;; Auto-generated. Do not edit!


(when (boundp 'sesionesPlanning::apunto)
  (if (not (find-package "SESIONESPLANNING"))
    (make-package "SESIONESPLANNING"))
  (shadow 'apunto (find-package "SESIONESPLANNING")))
(unless (find-package "SESIONESPLANNING::APUNTO")
  (make-package "SESIONESPLANNING::APUNTO"))
(unless (find-package "SESIONESPLANNING::APUNTOREQUEST")
  (make-package "SESIONESPLANNING::APUNTOREQUEST"))
(unless (find-package "SESIONESPLANNING::APUNTORESPONSE")
  (make-package "SESIONESPLANNING::APUNTORESPONSE"))

(in-package "ROS")





(defclass sesionesPlanning::apuntoRequest
  :super ros::object
  :slots (_direccion ))

(defmethod sesionesPlanning::apuntoRequest
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

(defclass sesionesPlanning::apuntoResponse
  :super ros::object
  :slots (_resultado ))

(defmethod sesionesPlanning::apuntoResponse
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

(defclass sesionesPlanning::apunto
  :super ros::object
  :slots ())

(setf (get sesionesPlanning::apunto :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get sesionesPlanning::apunto :datatype-) "sesionesPlanning/apunto")
(setf (get sesionesPlanning::apunto :request) sesionesPlanning::apuntoRequest)
(setf (get sesionesPlanning::apunto :response) sesionesPlanning::apuntoResponse)

(defmethod sesionesPlanning::apuntoRequest
  (:response () (instance sesionesPlanning::apuntoResponse :init)))

(setf (get sesionesPlanning::apuntoRequest :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get sesionesPlanning::apuntoRequest :datatype-) "sesionesPlanning/apuntoRequest")
(setf (get sesionesPlanning::apuntoRequest :definition-)
      "uint8 direccion
---
uint8 resultado

")

(setf (get sesionesPlanning::apuntoResponse :md5sum-) "049d75b744ba6418566a32f18f43c69c")
(setf (get sesionesPlanning::apuntoResponse :datatype-) "sesionesPlanning/apuntoResponse")
(setf (get sesionesPlanning::apuntoResponse :definition-)
      "uint8 direccion
---
uint8 resultado

")



(provide :sesionesPlanning/apunto "049d75b744ba6418566a32f18f43c69c")


