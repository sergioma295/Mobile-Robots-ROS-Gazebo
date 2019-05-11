rosinit('127.0.0.1');

global map
global inflateMap
global matrix_visited
global x
global y
global left_x
global left_y
global right_x
global right_y

inflateMap = 0;
matrix_visited = zeros(100,100);


sub = rossubscriber('/map',@callbackGRID);
sub2 = rossubscriber('/robot_pose_ekf/odom_combined','geometry_msgs/PoseWithCovarianceStamped',@callbackPOSITION);
sub3 = rossubscriber('/startMovement','std_msgs/Bool',@callbackMOVEMENT);
