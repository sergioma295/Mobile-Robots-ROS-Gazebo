from MODULOS import application as app, classes
import sys

"""
Sergio Masa
"""

def choose_map(index_map):
    if index_map == 0:
        name = "Maps/map1.csv"

    elif index_map == 1:
        name = "Maps/map2.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    elif index_map == 2:
        name = "Maps/map3.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    elif index_map == 3:
        name = "Maps/map4.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    elif index_map == 4:
        name = "../Maps/map5.csv"
        origin = classes.Point(4, 16)
        destiny = classes.Point(4, 10)

    elif index_map == 5:
        name = "Maps/map6.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    elif index_map == 6:
        name = "Maps/map7.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    elif index_map == 7:

        name = "Maps/map8.csv"
        origin = classes.Point(3, 3)
        destiny = classes.Point(11, 18)

    elif index_map == 8:

        name = "Maps/map9.csv"
        origin = classes.Point(2, 2)
        destiny = classes.Point(3, 3)

    return [name,origin,destiny]




def control_map(name):
    new_map = input("Do you want to load another map? [1-yes] - [0-no]: ")

    if new_map == 1:
        sys.exitfunc()
        index_map = input("\n\nChoose a index map: "
                          "\n 0-> map1"
                          "\n 1-> map2"
                          "\n 2-> map3"
                          "\n 3-> map4"
                          "\n 4-> map5"
                          "\n 5-> map6"
                          "\n 6-> map7"
                          "\n 7-> map8"
                          "\n 8-> map9"
                          "\n index_map: ")

        name = choose_map(index_map)

    else:
        name = name

    return name
init=0
exit = True
print("\n\nWelcome to path planning algorithm computer program in python.")
index_map = input("\n\nChoose a index map: "
                  "\n 0-> map1"
                  "\n 1-> map2"
                  "\n 2-> map3"
                  "\n 3-> map4"
                  "\n 4-> map5"
                  "\n 5-> map6"
                  "\n 6-> map7"
                  "\n 7-> map8"
                  "\n 8-> map9"
                  "\n index_map: ")


name=choose_map(index_map)
origin=name[1]
destiny=name[2]
name=name[0]


while exit==True:
    if init!=0:
        exit = input("Do you want to continue? [1-yes] - [0-no]: ")
        if exit == 1:
            exit = True
        elif exit == 0:
            exit = False
            break
        name=control_map(name)
    init=1
    print("\n\n Choose a algorithm to develop:"
          "\n\n0 -> BFS Algorithm"
          "\n1 -> DFS Algorithm"
          "\n2 -> GFS Algorithm"
          "\n3 -> A* Algorithm"
          "\n4 -> Dijstra Algorithm"
          "\n5 -> RRT Simple Algorithm"
          "\n6 -> RRT Algorithm")
    index=input("\nPlease you must choose an index which correspond to algorithm. Index: ")
    print("Procesando...")

    if index == 0:
        print("Your choice is: BFS Algorithm")
        app.bfs(origin,destiny,name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 1:
        print("Your choice is: DFS Algorithm")
        app.dfs(origin,destiny,name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 2:
        print("Your choice is: GFS Algorithm")
        app.gfs_complete(origin,destiny,name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 3:
        print("Your choice is: A* Algorithm")
        app.a_star(origin,destiny,name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 4:
        print("Your choice is: Dijstra Algorithm")
        app.dijkstra(origin, destiny, name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 5:
        print("Your choice is: RRT Algorithm")
        name='Maps/map0.csv'
        app.simple_rrt(name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")

    elif index == 6:
        print("Your choice is: RRT Algorithm")
        app.rrt(origin,destiny,name)
        print("Finish algorithm. Now you can choose another algorithm or conclude the program")




