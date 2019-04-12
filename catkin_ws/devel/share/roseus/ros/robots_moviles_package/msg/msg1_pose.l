;; Auto-generated. Do not edit!


(when (boundp 'robots_moviles_package::msg1_pose)
  (if (not (find-package "ROBOTS_MOVILES_PACKAGE"))
    (make-package "ROBOTS_MOVILES_PACKAGE"))
  (shadow 'msg1_pose (find-package "ROBOTS_MOVILES_PACKAGE")))
(unless (find-package "ROBOTS_MOVILES_PACKAGE::MSG1_POSE")
  (make-package "ROBOTS_MOVILES_PACKAGE::MSG1_POSE"))

(in-package "ROS")
;;//! \htmlinclude msg1_pose.msg.html


(defclass robots_moviles_package::msg1_pose
  :super ros::object
  :slots (_position _angle ))

(defmethod robots_moviles_package::msg1_pose
  (:init
   (&key
    ((:position __position) 0)
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _position (round __position))
   (setq _angle (float __angle))
   self)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; int32 _position
    4
    ;; float64 _angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _position
       (write-long _position s)
     ;; float64 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _position
     (setq _position (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _angle
     (setq _angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get robots_moviles_package::msg1_pose :md5sum-) "968abc20dbb963a7de947b6bafc3c12b")
(setf (get robots_moviles_package::msg1_pose :datatype-) "robots_moviles_package/msg1_pose")
(setf (get robots_moviles_package::msg1_pose :definition-)
      "int32 position
float64 angle

")



(provide :robots_moviles_package/msg1_pose "968abc20dbb963a7de947b6bafc3c12b")


