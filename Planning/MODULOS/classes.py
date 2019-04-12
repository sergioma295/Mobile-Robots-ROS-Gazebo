import pygame as pg
import time
import csv
import numpy as np
from MODULOS.constants import *


class Point():
    def __init__(self, row_point, column_point, dad_point=None):
        self.__row_point = row_point
        self.__column_point = column_point
        self.__dad_point = dad_point
        self.__heuristic=0
        self.__cost=0

    def get_row(self):
        """Method used to get the row of a point"""
        return self.__row_point

    def get_column(self):
        """Method used to get the column of a point"""
        return self.__column_point

    def get_dad(self):
        """Method used to get the dad of a point"""
        return self.__dad_point

    def set_dad(self, dad_point):
        """Method used to set the dad of a point"""
        self.__dad_point = dad_point

    def get_heuristic(self):
        """Method used to receive the heruistic component of a point"""
        return self.__heuristic

    def set_heuristic(self,heuristic):
        """Method used to receive the heruistic component of a point"""
        self.__heuristic=heuristic

    def get_cost(self):
        """Method used to receive the cost component of a point"""
        return self.__cost

    def set_cost(self,cost):
        """Method used to receive the cost component of a point"""
        self.__cost=cost

    def generate_children(self):
        """Method used to generate children of a point"""
        child1 = Point(self.__row_point - 1, self.__column_point, self)
        child2 = Point(self.__row_point, self.__column_point-1, self)
        child3 = Point(self.__row_point, self.__column_point + 1, self)
        child4 = Point(self.__row_point+1, self.__column_point, self)


        return [child1, child2, child3, child4]

    def __eq__(self, other):
        if other != None:
            return self.__column_point == other.get_column() and self.__row_point == other.get_row()
        else:
            return False

    def __hash__(self):
        return hash((self.__row_point, self.__column_point))

    def __ne__(self, other):
        if other != None:
            return self.__column_point != other.get_column() or self.__row_point != other.get_row()
        else:
            return True

#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------

class Map:
    def __init__(self,name):
        self.__name=name

    def plot_map(self):
        name=self.__name
        map=[]
        with open(name,'r') as csvfile:
            rows = csv.reader(csvfile, delimiter=',')
            number_rows = 0
            for r in rows:
                number_columns = len(r)
                number_rows += 1
                map = np.append(map, r)

        map = np.reshape(map, (number_rows, number_columns))
        visited_map=map.copy()
        self.__visited_map=visited_map
        dimenssion=[number_rows,number_columns]
        self.__dimenssion=dimenssion
        # Initialize pygame.
        pg.init()
        # Establish of Height and Width of the image screen
        dimenssion_screen = [

            Heigh * number_columns + Margin * number_columns + Margin,
            Width * number_rows + Margin * number_rows + Margin

        ]
        self.__dimenssionscreen=dimenssion_screen
        screen = pg.display.set_mode(dimenssion_screen)
        self.__screen=screen
        # Map Plot
        pg.display.set_caption("Map")
        for row in range(number_rows):
            for col in range(number_columns):
                if map[row][col] == '0':
                    color = White
                    self.drawMap((row, col), White)
                elif map[row][col] == '1':
                    color = Black
                    self.drawMap((row, col), Black)

        self.update_map()

    def update_map(self):
        pg.display.flip()


    def drawMap(self, point, color):
        row_point = point[0]
        column_point = point[1]

        pg.draw.rect(self.__screen, color,
                         [(Margin + Width) * column_point + Margin,
                          (Margin + Heigh) * row_point + Margin,
                          Width,
                          Heigh])

    def drawPoint(self, point, color,timesleep):
        """Method used for drawing a point in the map. timesleep < 0.05"""
        row_point = point.get_row()
        column_point = point.get_column()


        pg.draw.rect(self.__screen, color,
                     [(Margin + Width) * column_point + Margin,
                      (Margin + Heigh) * row_point + Margin,
                      Width,
                      Heigh])

        self.update_map()
        time.sleep(timesleep)

    def drawCircle(self,point,color,timesleep):
        row_point=point.get_row()
        column_point=point.get_column()

        pg.draw.circle(self.__screen, color, (self.__dimenssionscreen[0]/2, self.__dimenssionscreen[1]/2), 5)
        time.sleep(timesleep)

    def drawLine(self,point1,point2,timesleep,widthLine,color):
        """ Method used to draw a Line in the map"""
        screen = self.__screen
        # Point 1
        row_point1 = point1.get_row()
        column_point1 = point1.get_column()

        # Point 2
        row_point2 = point2.get_row()
        column_point2 = point2.get_column()

        pg.draw.line(screen, color,
                         ((Margin + Width) * column_point1 + Margin + 10,
                          (Margin + Heigh) * row_point1 + Margin + 10),
                         ((Margin + Width) * column_point2 + Margin + 10,
                          (Margin + Heigh) * row_point2 + Margin + 10),
                           widthLine)

        self.update_map()
        time.sleep(timesleep)

    def get_dimenssion(self):
        return self.__dimenssion

    def get_visited_map(self):
        return self.__visited_map

    def set_visited_map(self,row,col):
        self.__visited_map[row][col]='1'

    def get_visited_element_map(self,row,col):
        return self.__visited_map[row][col]

    def get_map_name(self):
        return self.__name


#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------

class PriorityQueue(object):
    def __init__(self):
        self.queue = []

        # for checking if the queue is empty

    def isEmpty(self):
        return len(self.queue) == 0

        # for inserting an element in the queue

    def insert(self, data):
        self.queue.append(data)

        # for popping an element based on Priority

    def delete(self):
        min = 0
        for i in range(len(self.queue)):
            if self.queue[i].get_heuristic() < self.queue[min].get_heuristic():
                min = i
        item = self.queue[min]
        del self.queue[min]
        return item



#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------


