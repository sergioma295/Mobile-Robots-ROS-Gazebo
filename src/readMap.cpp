#include "ros/ros.h"
#include "nav_msgs/OccupancyGrid.h"
#include "nav_msgs/MapMetaData.h"
#include "std_msgs/Header.h"

#include <iostream>

using namespace std;

ros::Publisher map_pub;

int c = 0;


void mapCallback(const nav_msgs::OccupancyGrid::ConstPtr& msg)
{

	cout << "Calculando..." << endl;

	int width = msg->info.width;
	int height = msg->info.height;
//	cout << "WIDTH " << msg->info.width << endl;
//	cout << "HEIGHT " << msg->info.height << endl;  
//	cout << "RESOLUTION " << msg->info.resolution << endl;
//	cout << "ORIGIN " << msg->info.origin.position.x << " " << msg->info.origin.position.y << " " << msg->info.origin.position.z << endl;	


  for(int i=0;i<width*height;i++) {
			if(msg->data[i] != -1)
				c++;
		}
	

	cout << "Nodos explorados = " << c/160 << " %" << endl;
	c = 0;
	cout << endl;


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

