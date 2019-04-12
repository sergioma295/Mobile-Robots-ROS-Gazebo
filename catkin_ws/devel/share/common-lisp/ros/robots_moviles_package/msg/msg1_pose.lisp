; Auto-generated. Do not edit!


(cl:in-package robots_moviles_package-msg)


;//! \htmlinclude msg1_pose.msg.html

(cl:defclass <msg1_pose> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type cl:integer
    :initform 0)
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass msg1_pose (<msg1_pose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <msg1_pose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'msg1_pose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robots_moviles_package-msg:<msg1_pose> is deprecated: use robots_moviles_package-msg:msg1_pose instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <msg1_pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-msg:position-val is deprecated.  Use robots_moviles_package-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <msg1_pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-msg:angle-val is deprecated.  Use robots_moviles_package-msg:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <msg1_pose>) ostream)
  "Serializes a message object of type '<msg1_pose>"
  (cl:let* ((signed (cl:slot-value msg 'position)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <msg1_pose>) istream)
  "Deserializes a message object of type '<msg1_pose>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'position) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<msg1_pose>)))
  "Returns string type for a message object of type '<msg1_pose>"
  "robots_moviles_package/msg1_pose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'msg1_pose)))
  "Returns string type for a message object of type 'msg1_pose"
  "robots_moviles_package/msg1_pose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<msg1_pose>)))
  "Returns md5sum for a message object of type '<msg1_pose>"
  "968abc20dbb963a7de947b6bafc3c12b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'msg1_pose)))
  "Returns md5sum for a message object of type 'msg1_pose"
  "968abc20dbb963a7de947b6bafc3c12b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<msg1_pose>)))
  "Returns full string definition for message of type '<msg1_pose>"
  (cl:format cl:nil "int32 position~%float64 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'msg1_pose)))
  "Returns full string definition for message of type 'msg1_pose"
  (cl:format cl:nil "int32 position~%float64 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <msg1_pose>))
  (cl:+ 0
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <msg1_pose>))
  "Converts a ROS message object to a list"
  (cl:list 'msg1_pose
    (cl:cons ':position (position msg))
    (cl:cons ':angle (angle msg))
))
