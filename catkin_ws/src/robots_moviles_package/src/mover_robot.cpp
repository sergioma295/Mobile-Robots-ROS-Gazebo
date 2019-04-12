// ROS Default Header File
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "nav_msgs/Odometry.h"
#include "robots_moviles_package/posicion.h"
#include <ros/console.h>


using namespace std;

double pos_x,pos_y,pos_z;
double ang_x,ang_y,ang_z,ang_w;
double vel_lin, vel_ang;


// Callback odometry
void odomCallback(const nav_msgs::Odometry::ConstPtr& odom)
{	
	ROS_INFO("OK");
	pos_x = odom->pose.pose.position.x;
	pos_y = odom->pose.pose.position.y;
	pos_z = odom->pose.pose.position.z;
	
	ang_x = odom->pose.pose.orientation.x;
	ang_y = odom->pose.pose.orientation.y;
	ang_z = odom->pose.pose.orientation.z;
	ang_w = odom->pose.pose.orientation.w;

	vel_lin = odom->twist.twist.linear.x;	
	vel_ang = odom->twist.twist.angular.z;
	
	
	cout<<"\nPOSITION "<<endl;
	cout<<"x: "<<pos_x<<endl;
	cout<<"y: "<<pos_y<<endl;
	cout<<"z: "<<pos_z<<endl;

	cout<<"\nORIENTATION"<<endl;
	cout<<"x: "<<ang_x<<endl; 
	cout<<"y: "<<ang_y<<endl;
	cout<<"z: "<<ang_z<<endl;
	cout<<"w: "<<ang_w<<endl;

	cout<<"\n VELOCITY"<<endl;
	cout<<"Linear: " <<vel_lin<<endl;
	cout<<"Angular: "<<vel_ang<<endl;
	
}



int main(int argc, char **argv) {			
	
	ros::init(argc,argv,"mover_robot_"); // Iniciamos el topic
	ros::NodeHandle n;
	ros::Subscriber subscriber_odometry=n.subscribe("odom",1000,odomCallback);
	



	
	ros::spin();

	

	return 0;
}
