#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/PoseStamped.h"
#include <iostream>

using namespace std;

ros::Publisher pub;


int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "publish_node");

  ros::NodeHandle n;

  pub = n.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1000);

 
  geometry_msgs::PoseStamped goal;

  goal.header.seq = 3;
  goal.header.stamp = ros::Time::now();
  goal.header.frame_id = "map";

  goal.pose.position.x = 1.0;
  goal.pose.position.y = 2.0;
  goal.pose.position.z = 0.0;

  goal.pose.orientation.x = 0.0;
  goal.pose.orientation.y = 0.0;
  goal.pose.orientation.z = 0.0;
  goal.pose.orientation.w = 1.0;

  ros::Duration(2.0).sleep(); // sleep for half a second
  pub.publish(goal);
  ros::spinOnce();
  ros::Duration(2.0).sleep(); // sleep for half a second




  return 0;
}

