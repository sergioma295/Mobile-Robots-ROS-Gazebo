#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include "geometry_msgs/Quaternion.h"
#include <iostream>

using namespace std;

ros::Publisher pub;
geometry_msgs::PoseWithCovarianceStamped initial_position;


int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "initial_pose");

  ros::NodeHandle n;


  pub = n.advertise<geometry_msgs::PoseWithCovarianceStamped>("initialpose", 1000);
  ros::Duration(0.5).sleep(); // sleep for half a second
	boost::shared_ptr<geometry_msgs::PoseWithCovarianceStamped const> sharedPtr;
	boost::shared_ptr<geometry_msgs::Quaternion const> sharedPtrLimits;
  ros::Duration(0.5).sleep(); // sleep for half a second 
 
	sharedPtr = ros::topic::waitForMessage<geometry_msgs::PoseWithCovarianceStamped>("/robot_pose_ekf/odom_combined", ros::Duration(10));
	sharedPtrLimits = ros::topic::waitForMessage<geometry_msgs::Quaternion>("/limits", ros::Duration(20));



  initial_position.header = sharedPtr->header;
  initial_position.header.frame_id = "map";
  initial_position.pose.covariance = sharedPtr->pose.covariance;

  //LIMITS IN X-AXIS

	if(sharedPtr->pose.pose.position.x > sharedPtrLimits->x)
		initial_position.pose.pose.position.x = sharedPtrLimits->x - 0.2;
  else if(sharedPtr->pose.pose.position.x < sharedPtrLimits->z)
		initial_position.pose.pose.position.x = sharedPtrLimits->z + 0.2;
	else
		initial_position.pose.pose.position.x = sharedPtr->pose.pose.position.x;

	//LIMITS IN Y-AXIS
	if(sharedPtr->pose.pose.position.y > sharedPtrLimits->y)
		initial_position.pose.pose.position.y = sharedPtrLimits->y - 0.2;
	else if(sharedPtr->pose.pose.position.y < sharedPtrLimits->w)
		initial_position.pose.pose.position.y = sharedPtrLimits->w + 0.2;
	else
		initial_position.pose.pose.position.y = sharedPtr->pose.pose.position.y;


	initial_position.pose.pose.position.z = sharedPtr->pose.pose.position.z;

  initial_position.pose.pose.orientation.x = sharedPtr->pose.pose.orientation.x;
  initial_position.pose.pose.orientation.y = sharedPtr->pose.pose.orientation.y;
  initial_position.pose.pose.orientation.z = sharedPtr->pose.pose.orientation.z;
  initial_position.pose.pose.orientation.w = sharedPtr->pose.pose.orientation.w;
 
	pub.publish(initial_position);
  ros::Duration(1.0).sleep(); // sleep for half a second
//  ros::Duration(1.5).sleep(); // sleep for half a second


  return 0;
}

