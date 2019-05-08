#include "ros/ros.h"
#include "nav_msgs/OccupancyGrid.h"
#include "nav_msgs/MapMetaData.h"
#include "std_msgs/Header.h"

#include <iostream>

using namespace std;

ros::Publisher map_pub;


void mapCallback(const nav_msgs::OccupancyGrid::ConstPtr& msg)
{

	cout << "WIDTH " << msg->info.width << endl;
	cout << "HEIGHT " << msg->info.height << endl;  
	cout << "RESOLUTION " << msg->info.resolution << endl;
	cout << "ORIGIN " << msg->info.origin.position.x << " " << msg->info.origin.position.y << " " << msg->info.origin.position.z << endl;	


  for(int i=0;i<480;i++) {
		printf("\n");
		for(int j=0;j<480;j++)
			printf("%i ",msg->data[i +  msg->info.width*j]);
}
//			printf("%i\n",msg->data[-100]);

//  std_msgs::Header header = msg->header;
//  nav_msgs::MapMetaData info = msg->info;
//  ROS_INFO("Got map %d %d", info.width, info.height);
//  Map map(info.width, info.height);
//  for (unsigned int x = 0; x < info.width; x++)
//    for (unsigned int y = 0; y < info.height; y++)
//      map.Insert(Cell(x,y,info.width,msg->data[x+ info.width * y]));

}

int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "reading_map");

  ros::NodeHandle n;

  srand(time(NULL));


  ros::Subscriber map_subs = n.subscribe("/map", 1000, mapCallback);

  ros::Rate loop_rate(10);

  while (ros::ok())
  {
    

    ros::spinOnce();


  }


  return 0;
}

