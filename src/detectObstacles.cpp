#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "std_msgs/Float64.h"
#include "std_msgs/Bool.h"
#include <math.h>
#include <stdlib.h>     /* srand, rand */
#include "sesionesPlanning/apunto.h"  
#include <vector>
#include <iostream>

using namespace std;

bool danger = false;
double angulo_z = 0;
float alpha = 5;

ros::Publisher in_front_of_obstacle;

void scanCallback(const sensor_msgs::LaserScan::ConstPtr& msg)
{

//   cout << msg->ranges[0] << endl;
//   cout << sizeof(msg->ranges) << " " << sizeof(msg->ranges[0]) << endl;
   int n = int((msg->angle_max - msg->angle_min)/msg->angle_increment);

   int count = 0;
//   if(count(msg->ranges,msg->ranges+n,nan) > 100)
   for(int i = 0; i < n ; i++)
	if(isnan(msg->ranges[i]) or msg->ranges[i] < 1)
		count++;

//   cout << "SIZE " << n << " COUNT " << count << endl;
   if(count > 100)
	danger = true;
   else
	danger = false;

   std_msgs::Bool d; d.data = danger;
   in_front_of_obstacle.publish(d);
}
	
void anguloCallback(const std_msgs::Float64::ConstPtr& msg)
{
	angulo_z = msg->data;
}

int getOrientation()
{
	if(angulo_z > -alpha and angulo_z < alpha) return 0;
	else if (angulo_z > 90-alpha and angulo_z < 90+alpha) return 1;
	else if (angulo_z > -90-alpha and angulo_z <  -90+alpha) return 2;
	else if ((angulo_z > -180-alpha and angulo_z <  -180+alpha) or (angulo_z > 180-alpha and angulo_z <  180+alpha)) return 3;
}


int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "detectObstacles");

  ros::NodeHandle n;

  ros::Subscriber odom_subs = n.subscribe("scan", 1000, scanCallback);
  in_front_of_obstacle = n.advertise<std_msgs::Bool>("/obstacleDetected", 1000);
  ros::service::waitForService("mover_en_direccion");
  ros::Subscriber orientation_z = n.subscribe("/angulo_z", 1000, anguloCallback);
  ros::ServiceClient client = n.serviceClient<sesionesPlanning::apunto>("mover_en_direccion");

  const int options[4] = {4,0,6,2};

  sesionesPlanning::apunto p;

  ros::Rate loop_rate(10);

  while (ros::ok())
  {
    

    ros::spinOnce();

    cout << rand()%8 << " aleatorio" << endl;

    if(danger) {
      int o = getOrientation();
	 cout << "ORIENTATION " << o << endl;
	 switch(o) {

		case 0:
		case 3:
			if((rand() % 10 +1) > 5)
				p.request.direccion = 0;
			else
				p.request.direccion = 4;
			break;
		case 1:
		case 2:
			if((rand() % 10 +1) > 5)
				p.request.direccion = 6;
			else
				p.request.direccion = 2;
			break;			

      }
	 client.call(p);
    } 
    else {
	 int index = rand()%4;
      p.request.direccion = options[index]; //Numero aleatorio entre 0-7
      client.call(p);
    }	     

    cout << "DIRECCION " << p.request.direccion << endl;

    loop_rate.sleep();
   
  }


  return 0;
}
