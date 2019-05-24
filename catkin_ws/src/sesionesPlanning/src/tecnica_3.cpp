#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/LaserScan.h"
#include "std_msgs/Float64.h"
#include "geometry_msgs/Twist.h"
#include "nav_msgs/Odometry.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include "geometry_msgs/Point.h"
#include "sesionesPlanning/apunto.h"
#include <tf/tf.h>
#include <iostream>

using namespace std;

geometry_msgs::Point punto_actual;
int orientacionActual = 0;
float alpha = 7;
bool danger = false;
bool danger_medium=false;
int recuerdo = 99; 
int direccion = 0;
double angulo=0;
ros::Publisher mueve_robot;

void scanCallback(const sensor_msgs::LaserScan::ConstPtr& msg)
{


   int n = int((msg->angle_max - msg->angle_min)/msg->angle_increment);

   int count = 0;
   
   int lim_inf = n/4;
   int lim_sup = lim_inf + n/4;
   for(int i = 0; i < n ; i++) {
     bool de_frente = (i >= lim_inf and i<=lim_sup); 
	if(de_frente && isnan(msg->ranges[i]) or msg->ranges[i] < 0.8)
		count++;

   }
   // cout << "Numero de obstaculos: " << count << endl;
   if(count > 200)
	danger = true;
   else
	danger = false;

}

int getOrientation()
{
     double angulo_sin_signo = angulo;
     if (angulo < 0)
     	angulo_sin_signo = 360 - abs(angulo);

//	cout << "ANGULO SIN SIGNO: " << angulo_sin_signo << endl;

     int d = 9;

	if((angulo_sin_signo > -alpha and angulo_sin_signo < alpha) or (angulo_sin_signo > 360-alpha and angulo_sin_signo < 360+alpha)) d = 0;
	else if (angulo_sin_signo > 90-alpha and angulo_sin_signo < 90+alpha) d = 1;
	else if (angulo_sin_signo > 180-alpha and angulo_sin_signo <  180+alpha) d = 2;
	else if (angulo_sin_signo > 270-alpha and angulo_sin_signo <  270+alpha) {d = 3;}

//     cout << "D: " << d << " B: " << (angulo_sin_signo > 270-alpha and angulo_sin_signo <  270+alpha) <<  endl;
     return d;
}


void odomCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg)
{
	punto_actual.x = msg->pose.pose.position.x;
	punto_actual.y = msg->pose.pose.position.y;
	
	tf::Quaternion q(msg->pose.pose.orientation.x,
                         msg->pose.pose.orientation.y,
			 msg->pose.pose.orientation.z,
			 msg->pose.pose.orientation.w);

	tf::Matrix3x3 m(q);
	double roll, pitch, yaw;
	m.getRPY(roll, pitch, yaw);
	angulo = yaw;
	angulo = (360*angulo)/(2*3.1415);
}

void avanza(float distancia){
	geometry_msgs::Twist msg;
    msg.linear.x = 0.3;
//    ROS_INFO("Enviando %f como velocidad en x", msg.linear.x);
    mueve_robot.publish(msg);
    
    ros::Rate loop_rate(15);
    
    double piX = punto_actual.x;
    double piY = punto_actual.y;
    
    double pfX = piX;
    double pfY = piY;
    
	
	while (ros::ok() && (sqrt(pow((piX - pfX),2) + pow((piY-pfY),2)) < distancia) && not danger)
  {

	pfX = punto_actual.x;
	pfY = punto_actual.y;
//	cout << "He recorrido "<< sqrt(pow((piX - pfX),2) + pow((piY-pfY),2))<< endl; 
	mueve_robot.publish(msg);
    ros::spinOnce();

    loop_rate.sleep();
   
  }
    
}

bool distanciaAlcanzada(geometry_msgs::Point distanciaInicial, float distanciaPedida){
//	cout << "He recorrido "<< abs(punto_actual.x - distanciaInicial.x) << " metros" << endl;
	return ( abs(punto_actual.x - distanciaInicial.x) > distanciaPedida);
}




bool ponteEnAngulo(double anguloGiro){
	geometry_msgs::Twist msg;
	//a la derecha negativo, a la izquierda positivo
	
    double angulo_actual;
    angulo_actual= angulo;
	if (angulo_actual < 0){
		angulo_actual = 360 - abs(angulo_actual);
	}
	
	double angulo_final_giro = anguloGiro;
	
	ros::Rate loop_rate(10);
	
	int signo = 1;

	if ((angulo_actual > angulo_final_giro) && ((angulo_actual - angulo_final_giro) < 180)){
		signo = -1;
	}
    msg.angular.z = 0.2*signo;
    
    // ROS_INFO("Enviando %f como velocidad en z", msg.angular.z);
 
    while (ros::ok() && abs(angulo_actual - angulo_final_giro) > 0.7)
  {
	angulo_actual = angulo;
	if (angulo_actual < 0){
		angulo_actual = 360 - abs(angulo_actual);
	}
	if (angulo_actual > 359 && angulo_actual < 360.1){
		angulo_actual = 0;
	}
    
    //cout << "Angulo actual es " << angulo << " y tiene que alcanzar " << angulo_final_giro << ". El ángulo actual sin signo es " << angulo_actual<< endl;
	mueve_robot.publish(msg);
    ros::spinOnce();

    loop_rate.sleep();
   
  }
    
}


bool moverEnDireccion(int direccion)
{
  float distancia = 0.75;
  switch (direccion){
	  case 0:
		ponteEnAngulo(90);
	  	break;
	  case 1:
		ponteEnAngulo(45);
	  	break;
	  case 2:
		ponteEnAngulo(0);
	  	break;
	  case 3:
		ponteEnAngulo(315);
	  	break;
	  case 4:
		ponteEnAngulo(270);
	  	break;
	  case 5:
		ponteEnAngulo(225);
	  	break;
	  case 6:
		ponteEnAngulo(180);
	  	break;
	  case 7:
		ponteEnAngulo(135);
	  	break;

	  case 8: 		
	  	avanza(distancia);
	  	break;
  }
  
//  cout << "Voy a enviar un 77" << endl;
//  cout << "Y el ángulo es " << angulo << endl;
  
  
  return true;
}

bool evitar_obstaculo(int o){

	if(o>(-30) and o<30){
		cout<<"Angulo a 90º"<<endl;
		ponteEnAngulo(90);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if(o>80 and o<100){
		cout<<"Angulo a 180º"<<endl;
		ponteEnAngulo(180);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if(o>170 and o<190){
		cout<<"Angulo a 270º"<<endl;
		ponteEnAngulo(270);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if((o>250 and o<280)){
		cout<<"Angulo a 0º"<<endl;
		ponteEnAngulo(0);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();
	}else{
		cout<<"Sin movimiento"<<endl;
		cout<<"Angulo a 0º"<<endl;
		ponteEnAngulo(0);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();
	}
}


bool seguir_pared(int o){
	if(o>(-20) and o<20){
		cout<<"Angulo a 270º"<<endl;
		ponteEnAngulo(270);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if(o>70 and o<110){
		cout<<"Angulo a 0º"<<endl;
		ponteEnAngulo(0);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if((o>160 and o<200)){
		cout<<"Angulo a 90º"<<endl;
		ponteEnAngulo(90);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();

	}else if((o>250 and o<280)){
		cout<<"Angulo a 180º"<<endl;
		ponteEnAngulo(180);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();
	}else{
		cout<<"Sin movimiento"<<endl;
		cout<<"Angulo a 180º"<<endl;
		ponteEnAngulo(180);
		cout<<"Angulo "<<angulo<<endl;
		ros::Duration(2).sleep();
	}
}

int obtener_orientacion(double angulo){

	int angulo_ = abs(angulo);
	return angulo_;
}
int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "moving_obstacles");

  ros::NodeHandle n;

  srand(time(NULL));

  mueve_robot = n.advertise<geometry_msgs::Twist>("mobile_base/commands/velocity", 1000);

  ros::Subscriber scan_subs = n.subscribe("/scan", 1000, scanCallback);
  ros::Subscriber odom_subs = n.subscribe("/robot_pose_ekf/odom_combined", 1000, odomCallback);

  ros::Rate loop_rate(10);

  const int options[4] = {0,4,6,2};
  int iteracion = 0;
  int contador = 0;
  int o;
  int limit = 4;
  bool first_time = true;
  int vuelta=0;
  int anterior=0;

	if(first_time){
		cout<<"--------------------------------------------------"<<endl;
		cout<<"---------------- TURTELBOT ROS -------------------"<<endl;
		cout<<"--------------------------------------------------"<<endl;
		first_time = false;
	}
  while (ros::ok()){
    

    ros::spinOnce();


	if(danger){
		first_time = true;
		cout<<"--------------------------------------------"<<endl;
		cout<<"---------------- PELIGRO -------------------"<<endl;
		cout<<"--------------------------------------------"<<endl;
		cout<<"[INFO] Orientacion: "<<angulo<<endl;
		cout<<"... Evitando obstaculo ..."<<endl;
		//ros::Duration(5).sleep(); // sleep for half a second
		evitar_obstaculo(angulo);
		//ros::Duration(5).sleep(); // sleep for five seconds
		cout<<"[INFO] Nueva orientacion: "<<angulo<<endl;
		cout<<"--------------------------------------------"<<endl;


	}else{
		cout<<"--------------------------------------------"<<endl;
		cout<<"---------------- SEGURO --------------------"<<endl;
		cout<<"--------------------------------------------"<<endl;

		if(first_time==false){
			cout<<"Primera iteracion"<<endl;
			direccion = 8;
			cout<<"... Avanzando ... "<<endl;
			avanza(0.5);
		}else{
			direccion = 8;
			cout<<"... Avanzando ... "<<endl;
			avanza(0.5);

			cout<<"[INFO] Orientacion: "<<angulo<<endl;
			cout<<"Seguir pared activado"<<endl;
			seguir_pared(angulo);
			cout<<"Peligro: "<<danger<<endl;
			if(danger){
				cout<<"Pared encontrada"<<endl;
				cout<<"[INFO] Orientacion: "<<angulo<<endl;
				cout<<"Evitar obstaculo activado"<<endl;
				evitar_obstaculo(angulo);


			}else{
				cout<<"NADA encontrado"<<endl;
				cout<<"... Avanzando ... "<<endl;
				avanza(0.5);

			}
			
			cout<<"--------------------------------------------"<<endl;

		}

			
			cout<<"--------------------------------------------"<<endl;

		


	}
	

    loop_rate.sleep();
 }
  return 0;
}

