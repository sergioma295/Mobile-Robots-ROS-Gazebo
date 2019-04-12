#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include <iostream>

using namespace std;

ros::Publisher pub;

void odomCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg)
{
	pub.publish(*msg);
     ros::Duration(0.5).sleep(); // sleep for half a second

}

int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "initial_pose");

  ros::NodeHandle n;


  ros::Subscriber odom_subs = n.subscribe("/robot_pose_ekf/odom_combined", 1000, odomCallback);
  pub = n.advertise<geometry_msgs::PoseWithCovarianceStamped>("initialpose", 1000);

 
  while (ros::ok())
  {
    

    ros::spinOnce();
   
  }


  return 0;
}

