#include <ros/ros.h>
#include <laser_assembler/AssembleScans.h>
#include "sensor_msgs/PointCloud.h"


using namespace laser_assembler;
int main(int argc, char **argv)
{
  ros::init(argc, argv, "assembling");
  ros::NodeHandle n;
  ros::service::waitForService("assemble_scans");
  ros::ServiceClient client = n.serviceClient<AssembleScans>("assemble_scans");
  ros::Publisher pub_cloud = n.advertise<sensor_msgs::PointCloud>("/assembled_cloud", 10);

  AssembleScans srv;

  srv.request.begin = ros::Time::now();
  ros::Duration(120).sleep();
  srv.request.end   = ros::Time::now();

  if (client.call(srv)) {
    std::cout << "Voy a ello" << std::endl;
    ros::Duration(4.0).sleep();
    printf("Got cloud with %u points\n", srv.response.cloud.points.size());
    pub_cloud.publish(srv.response.cloud);

    ros::Duration(4.0).sleep();
  }
  else
    printf("Service call failed\n");


  ros::Duration(10).sleep();
  return 0;
}
