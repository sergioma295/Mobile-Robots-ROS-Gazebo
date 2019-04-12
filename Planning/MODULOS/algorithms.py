import random
import math
import time
from MODULOS import  classes



from MODULOS.classes import *

class algorithms():
    def __init__(self,name,):
        self.__name=name
        self.__a = 1
        self.__map = Map(name)
        self.__map.plot_map()
        self.__dimenssion = self.__map.get_dimenssion()
        self.__numNodes = 0

    def get_num_nodes(self):
        return self.__numNodes

    def reset_nodes(self):
        self.__numNodes = 0
#-----------------------------------------------------------------------------------------------------------------------
#--------------------------------------       BFS       ----------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

    def bfs(self,q,origin,destiny):
        """BFS Algorithm in algorithms.py"""

        self.__map.drawPoint(origin, Magenta,0)
        self.__map.drawPoint(destiny, Yellow,0)

        self.__map.set_visited_map(origin.get_row(), origin.get_column())

        while not q.empty():
            current = q.get()
            if current == destiny:
                return current
            else:
                self.__map.drawPoint(current, Green,0.0003)
                self.__numNodes = self.__numNodes+1

            children = current.generate_children()

            for child in children:
                if child.get_row() >= 0 and child.get_column() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() < self.__dimenssion[1] and \
                                self.__map.get_visited_element_map(child.get_row(), child.get_column()) != '1':
                    q.put(child)
                    self.__map.set_visited_map(child.get_row(), child.get_column())
#-----------------------------------------------------------------------------------------------------------------------
#------------------------------------------ DFS ------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
    def dfs(self,q,origin,destiny):
        """DFS Algorithm in algorithms.py"""
        # Drawing origin and destiny point in the map
        self.__map.drawPoint(origin, Magenta,0)
        self.__map.drawPoint(destiny, Yellow,0)


        # Setting origin like visited
        self.__map.set_visited_map(origin.get_row(), origin.get_column())

        while len(q) != 0:
            current = q.pop()

            if current == destiny:
                return current
            else:
                self.__map.drawPoint(current, Green,0.00055)
                self.__numNodes = self.__numNodes+1

            children = current.generate_children()

            for child in children:
                if child.get_row() >= 0 and child.get_column() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() < self.__dimenssion[1] and \
                                self.__map.get_visited_element_map(child.get_row(), child.get_column()) != '1':
                    q.append(child)
                    self.__map.set_visited_map(child.get_row(), child.get_column())

#-----------------------------------------------------------------------------------------------------------------------
#----------------------------------      GFS  INCOMPLETE          ------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

    def gfs_incomplete(self,q,origin,destiny):

        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)

        inf = 999999999

       # Setting origin like visited
        self.__map.set_visited_map(origin.get_row(), origin.get_column())

        while not q.isEmpty():
            actual = q.delete()
            if actual == destiny:
                return actual
            else:
                self.__map.drawPoint(actual,Green,0)

            children = actual.generate_children()

            min_h = inf
            index_min = inf
            it = 0
            for child in children:
                if child.get_row() >= 0 and child.get_column() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() < self.__dimenssion[1] and \
                              self.__map.get_visited_element_map(child.get_row(), child.get_column())   != '1':

                    if(self.heruistic(child,destiny) < min_h):
                        min_h = self.heruistic(child,destiny)
                        index_min = it
                it = it + 1

            if(index_min != inf):
                q.insert(children[index_min])
                self.__map.set_visited_map(children[index_min].get_row(), children[index_min].get_column())

            return self.gfs_incomplete(q,origin, destiny)

#-----------------------------------------------------------------------------------------------------------------------
#--------------------------------------------      GFS  COMPLETE          ------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
    def gfs_complete(self,q,origin,destiny):

        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)

        # Setting origin like visited
        self.__map.set_visited_map(origin.get_row(), origin.get_column())

        while not q.isEmpty():
            actual = q.delete()
            if actual == destiny:
                return actual
            if actual != origin:
                self.__map.drawPoint(actual,Green,0.0005)
                self.__numNodes = self.__numNodes+1

            children = actual.generate_children()


            for child in children:
                if child.get_row() >= 0 and child.get_column() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() < self.__dimenssion[1] and \
                              self.__map.get_visited_element_map(child.get_row(), child.get_column())   != '1':

                    child.set_heuristic(self.heruistic(child,destiny))
                    q.insert(child)
                    self.__map.set_visited_map(child.get_row(), child.get_column())

#-----------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------   A STAR    -------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

    def a_star(self,origin,destiny):
        """A* Algorithm in algorithms.py"""
        # f(n)=g(n)+h(n)

        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)



        # Definition of the set (OpenSet and ClosedSet)

        # Define the closedSet (children been expanded yet)
        closedset = set()

        # Define the openSet (their children have not been generated)
        openset = set()
        current = origin

        # Add the origin to open set
        openset.add(current)

        while openset:
            # Find the point with minimoun f(n) = g(n) + h(n)
            current = min(openset, key=lambda o: o.get_cost() + o.get_heuristic())

            # Check if destiny
            if current==destiny:
                return current

            self.__numNodes = self.__numNodes+1
            # Remove from open set
            openset.remove(current)
            # Add to closed set
            closedset.add(current)

            if current != origin:
                self.__map.drawPoint(current, Green, 0)

            children = current.generate_children()

            for child in children:
                if child.get_row() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() >= 0  and child.get_column() < self.__dimenssion[1] and \
                                self.__map.get_visited_element_map(child.get_row(), child.get_column()) != '1':

                    if child in closedset:
                        continue

                    new_cost = current.get_cost() + self.dist(current, child)  # Distance from start to neighbor. It is 1 because the distance is 1 between parent and children
                    # It is the open set
                    if child not in openset:
                        child.set_cost(new_cost)
                        child.set_heuristic(self.heruistic(child, destiny))
                        child.set_dad(current)
                        openset.add(child)

                    elif new_cost < child.get_cost():  # Node in open set and new Parent
                        child.set_cost(new_cost)
                        child.set_dad(current)

#-----------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------   DIJKSTRA    -----------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

    def dijkstra(self,origin,destiny):
        """dijkstra Algorithm in algorithms.py"""
        # Plotting origin and destiny point
        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)

        # Define the closedSet (children been expanded yet)
        closedset = set()

        # Define the openSet (their children have not been generated)
        openset = set()

        # Starting point
        current = origin

        # Add the origin to open set
        openset.add(current)

        while openset:
            # Find the point with minimoun f(n) = g(n) + h(n)
            current = min(openset, key=lambda o: o.get_cost())

            # Check if destiny
            if current == destiny:
                destiny = current

            self.__numNodes = self.__numNodes+1
            # Remove from open set
            openset.remove(current)
            # Add to closed set
            closedset.add(current)

            if current != origin and current != destiny:
                self.__map.drawPoint(current, Green, 0)

            children = current.generate_children()

            for child in children:
                if child.get_row() >= 0 and child.get_column() >= 0 and child.get_row() < self.__dimenssion[0] and child.get_column() < self.__dimenssion[1] and \
                                self.__map.get_visited_element_map(child.get_row(), child.get_column()) != '1':

                    if child in closedset:
                        continue

                    new_cost = current.get_cost() + self.dist(current, child)  # Distance from start to neighbor. It is 1 because the distance is 1 between parent and children
                    # It is the open set
                    if child not in openset:
                        child.set_cost(new_cost)
                        child.set_dad(current)
                        openset.add(child)


                    elif new_cost < child.get_cost(): # Node in open set and new Parent
                        child.set_cost(new_cost)
                        child.set_dad(current)
        return destiny

    def simple_rrt(self):
        origin=Point(int(self.__dimenssion[0] / 2), int(self.__dimenssion[1] / 2))
        tree = set()
        tree.add(origin)
        grew_factor = 1  # step is the step to change the position.
        number_iteration=pow(self.__dimenssion[0]*self.__dimenssion[1],2)
        self.__map.drawCircle(origin,Black,0)

        for i in range(number_iteration):
            print("Iteration number: " ,i)
            # Current value is a random point in the map.
            x_rand = random.random()*self.__dimenssion[0]
            y_rand = random.random()*self.__dimenssion[1]
            current = Point(x_rand, y_rand)

            # Get the point nearest than current in the tree.
            random_point = min(tree, key=lambda o: self.dist(o, current))
            self.__numNodes = self.__numNodes+1

            # Check if current is not the new point and the distance between both points is less than the step.
            if current != random_point and self.dist(current,random_point) <= grew_factor:
                self.__map.drawLine(random_point, current, 0,1,Black)
                tree.add(current)

#-----------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------   RRT    ----------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

    def rrt(self,origin,destiny):
        tree = set()
        tree.add(origin)
        found = False
        number_iteration = pow(self.__dimenssion[0]*self.__dimenssion[1],2)
        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)
        timeE = 0
        for i in range(number_iteration):
            start = time.time()
            print("iteration: ",i)

            x_rand = int(random.uniform(0, self.__dimenssion[0]))
            y_rand = int(random.uniform(0, self.__dimenssion[1]))

            # Current value is a random point in the map.
            qn = Point(x_rand, y_rand)
            nearest_point = min(tree, key=lambda o: self.cost(o, qn))

            # Check if current is not the new point and the distance between both points is less than the step.
            if qn != nearest_point and self.dist(qn,nearest_point) <= grew_factor:
                q=self.collison_detector(nearest_point, qn)
                self.__map.drawLine(nearest_point, q, 0,3,Green)
                q.set_dad(nearest_point)
                tree.add(q)
                self.__numNodes = self.__numNodes+1

                if q == destiny:
                    found=True
                    break
            else:
                end = time.time()
                timeE = timeE + (end-start)

        return [q,found,timeE]

#-----------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------   BIDIRECTIONAL RRT    ----------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
    def bidirectional_rrt(self,origin,destiny):
        Tree_origin = set()
        Tree_destiny = set()

        self.__map.drawPoint(origin, Magenta, 0)
        self.__map.drawPoint(destiny, Yellow, 0)
        Tree_origin.add(origin)
        Tree_destiny.add(destiny)
        #time.sleep(10)
        number_iteration = pow(self.__dimenssion[0] * self.__dimenssion[1], 2)
        found = False
        timeE = 0

        for i in range(number_iteration):
            start = time.time()
            x_rand = int(random.uniform(0,self.__dimenssion[0]))
            y_rand = int(random.uniform(0,self.__dimenssion[1]))

            qn1 = Point(x_rand,y_rand)
            qn2 = Point(x_rand,y_rand)

            nearest_point1 = min(Tree_origin,key = lambda o: self.cost(o,qn1))

            if qn1 != nearest_point1 and self.dist(nearest_point1,qn1) <= grew_factor:
                    q1 = self.collison_detector(nearest_point1, qn1)
                    q1.set_dad(nearest_point1)
                    Tree_origin.add(q1)
                    self.__map.drawLine(nearest_point1, q1, 0, 2, Green)
                    self.__numNodes = self.__numNodes+1

                    nearest_point2 = min(Tree_destiny,key = lambda o: self.cost(o,qn2))

                    if qn2 != nearest_point2 and self.cost(nearest_point2,qn2) <= grew_factor:
                        q2 = self.collison_detector(nearest_point2, qn2)
                        q2.set_dad(nearest_point2)
                        Tree_destiny.add(q2)
                        self.__map.drawLine(nearest_point2, q2, 0, 2, Green)

                    if len(Tree_origin) > len(Tree_destiny):
                        tree_aux = Tree_origin
                        Tree_origin = Tree_destiny
                        Tree_destiny = tree_aux

                    if nearest_point1 == nearest_point2:
                        found = True
                        break
            else:
                end = time.time()
                timeE = timeE + (end-start)


        return [nearest_point1,nearest_point2,found,timeE]


    def collison_detector(self,point1,point2):
        if self.__map.get_visited_element_map(point2.get_row(),point2.get_column()) == '1':
            state=1
            q = self.stop_configuration(state, point1, point2)

        else:
            state=0
            q=self.stop_configuration(state,point1, point2)
        return q

    def stop_configuration(self,state,point1,point2):
        """Method to detect some collision"""
        N_POINTS = 50  # Number of point to check the line between two points.
        qs=point2
        if state==1:
            # Many amount of points do to algorithm more precise but slower

            # Row_Point ---  Y
            # Col_point ---- X

            # There are two cases. Knowing about y=mx+n. The equation of the line between two points is calculated
                # by:

                #  y:row|
                #       |
                #       |
                #       |                  x (x2,y2)          |      y1 = m*x1 + n
                #       |                 /                   |
                #       |                /                    |      y2 = m*x2 + n
                #       |               /    y=mx+n:--------->|    __________________
                #       |              /                      |    | y1-y2=m(x1-x2) |
                #       |             /                       |    | n=y1-m*x1      |
                #       |    (x1,y1) x                             |________________|
                #       |_______________________________________________
                #                                                   x: col
                # m =(y1-y2)/(x1-x2)
                # n = y1-m*x1
                # On this way:  Case 1 -> m=(y1-y2)/0  -> Points in the same column
                #               Case 2 -> cc


            # Case 2. Checking if the points are not in the same column
            if point1.get_column() - point2.get_column() != 0:

                # Getting the equation line.
                m = (point1.get_row() - point2.get_row()) / (point1.get_column() - point2.get_column())
                n = point1.get_row() - m * point1.get_column()

                # Checking if there are any obstacle in the line. -1 component involve the grow sense
                #                                                 1.0 component involve a float variable return
                x_increase = (-1) * (point1.get_column() - point2.get_column()) / (N_POINTS * 1.0)
                for i in range(N_POINTS):
                    # Check if the point (point+x,y) in the line its over a obstacle
                    x = int(point1.get_column() + (i) * x_increase)
                    y = int(m * x + n)
                    if self.__map.get_visited_element_map(y, x) == '0':
                        qs=Point(y,x)
                        continue


            # Case 1. Points in the same column. With identical value of x
            else:
                # The procedure is the same but we know about the slape = 0 . so y=mx+n = y=n
                x = point1.get_column()
                x_increase = (point2.get_row() - point1.get_row()) / (N_POINTS * 1.0)

                for i in range(N_POINTS):
                    y = int(point1.get_row() + x_increase * i)
                    y = int(y)

                    if self.__map.get_visited_element_map(y, x) == '0':
                        qs = Point(y, x)
                        continue


        else:
            # Many amount of points do to algorithm more precise but slower

            # Row_Point ---  Y
            # Col_point ---- X

            # There are two cases. Knowing about y=mx+n. The equation of the line between two points is calculated
            # by:

            #  y:row|
            #       |
            #       |
            #       |                  x (x2,y2)          |      y1 = m*x1 + n
            #       |                 /                   |
            #       |                /                    |      y2 = m*x2 + n
            #       |               /    y=mx+n:--------->|    __________________
            #       |              /                      |    | y1-y2=m(x1-x2) |
            #       |             /                       |    | n=y1-m*x1      |
            #       |    (x1,y1) x                             |________________|
            #       |_______________________________________________
            #                                                   x: col
            # m =(y1-y2)/(x1-x2)
            # n = y1-m*x1
            # On this way:  Case 1 -> m=(y1-y2)/0  -> Points in the same column
            #               Case 2 -> cc


            # Case 2. Checking if the points are not in the same column
            if point1.get_column() - point2.get_column() != 0:

                # Getting the equation line.
                m = (point1.get_row() - point2.get_row()) / (point1.get_column() - point2.get_column())
                n = point1.get_row() - m * point1.get_column()

                # Checking if there are any obstacle in the line. -1 component involve the grow sense
                #                                                 1.0 component involve a float variable return
                x_increase = (-1) * (point1.get_column() - point2.get_column()) / (N_POINTS * 1.0)
                for i in range(N_POINTS):
                    # Check if the point (point+x,y) in the line its over a obstacle
                    x = int(point1.get_column() + (i) * x_increase)
                    y = int(m * x + n)

                    # Checking the map component with the new variable.
                    if self.__map.get_visited_element_map(y, x) == '1':
                        x = int(point1.get_column() + (i -1 ) * x_increase)
                        y = int(m * x + n)
                        print("checking...",y,x)
                        if self.__map.get_visited_element_map(y, x) == '0':
                            qs = Point(y, x)
                            continue


            # Case 1. Points in the same column. With identical value of x
            else:
                # The procedure is the same but we know about the slape = 0 . so y=mx+n = y=n
                x = point1.get_column()
                x_increase = (point2.get_row() - point1.get_row()) / (N_POINTS * 1.0)

                for i in range(N_POINTS):
                    y = int(point1.get_row() + x_increase * i)

                    y = int(y)
                    if self.__map.get_visited_element_map(y, x) == '1':
                        y = int(point1.get_row() + x_increase * (i -1))
                        if self.__map.get_visited_element_map(y, x) == '0':
                            qs = Point(y, x)
                            continue



        return qs

    def plot_road(self,origin,destiny):
        daddy = destiny.get_dad()
        coste_camino = 0
        road=[destiny]
        while daddy!=origin:
            self.__map.drawPoint(daddy,Blue,0.0005)
            road.append(daddy)
            coste_camino = coste_camino + self.dist(daddy,daddy.get_dad())
            daddy = daddy.get_dad()

        road_inv = road[::-1]
        road = [origin] + road_inv

        print("Coste del camino encontrado: "+str(coste_camino))
        time.sleep(1)

        for i in range(1,len(road)):
            time.sleep(0.1)
            self.__map.drawPoint(road[i], Magenta, 0)
            self.__map.drawPoint(road[i-1], Blue, 0)

        time.sleep(1)

    def plot_road_rrt(self,origin,destiny,current):
        road_cost = 0
        while current != origin:
            self.__map.drawLine(current,current.get_dad(),0,3,Blue)
            road_cost = road_cost + self.dist(current,current.get_dad())
            current=current.get_dad()
        print("Coste del camino: "+str(road_cost))
        time.sleep(3)

    def plot_road_bidirectional_rrt(self,origin,destiny,nearest_point1,nearest_point2):
        road_cost = 0

        while nearest_point1 != destiny and nearest_point1 != origin:
            self.__map.drawLine(nearest_point1, nearest_point1.get_dad(),0,3,Blue)
            road_cost = road_cost + self.dist(nearest_point1,nearest_point1.get_dad())
            nearest_point1=nearest_point1.get_dad()

        while nearest_point2 != origin and nearest_point2 != destiny:
            self.__map.drawLine(nearest_point2, nearest_point2.get_dad(),0,3, Blue)
            road_cost = road_cost + self.dist(nearest_point2,nearest_point2.get_dad())
            nearest_point2=nearest_point2.get_dad()
        print("Coste del camino: "+str(road_cost))
        time.sleep(3)


    def cost(self,point1,point2):
        """Method used to set the cost component of a point"""
        return abs(point1.get_row()- point2.get_row()) + abs(point1.get_column() - point2.get_column())


    def dist(self,point1,point2):
        """Method used to set the cost component of a point"""
        return math.sqrt(math.pow(point1.get_row()- point2.get_row(),2) + math.pow(point1.get_column() - point2.get_column(),2))


    def heruistic(self,point1,point2):
        """Method used to set the heruistic component of a point"""
        return (math.sqrt(math.pow(point1.get_row()-point2.get_row(),2) + math.pow(point1.get_column()-point2.get_column(),2)))


