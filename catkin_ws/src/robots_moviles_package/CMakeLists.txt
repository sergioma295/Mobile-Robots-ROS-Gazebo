cmake_minimum_required(VERSION 2.8.3)
project(robots_moviles_package)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs message_generation tf nav_msgs geometry_msgs)


## Generate messages in the 'msg' folder
add_message_files(FILES msg1_pose.msg)

## Generate services in the 'srv' folder
add_service_files(FILES serv1_posicion.srv)

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
generate_messages(DEPENDENCIES std_msgs)


## DEPENDS: system dependencies of this project htat depend projects also need
catkin_package(
   INCLUDE_DIRS include
   # LIBRARIES robots_moviles_package
   CATKIN_DEPENDS roscpp rospy std_msgs  
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(${catkin_INCLUDE_DIRS})



## Build option for "mover_robot" node.
add_executable(mover_robot src/mover_robot.cpp)
add_dependencies(mover_robot ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(mover_robot ${catkin_LIBRARIES})


