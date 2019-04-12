import pygame
import Queue
import os
import time
from pygame.locals import *
from MODULOS import application as app, classes
from MODULOS import algorithms as alg

class GUI():
    def __init__(self):

        # Colors
        self.__white = (255, 255, 255)
        self.__black = (0, 0, 0)
        self.__gray = (
            50, 50, 50)
        self.__red = (255, 0, 0)
        self.__green = (0, 255, 0)
        self.__blue = (0, 0, 255)
        self.__yellow = (255, 255, 0)

        self.initializeInterface()

    def initializeInterface(self):
        # Game Initialization

        pygame.init()

        # Center the Game Application
        os.environ['SDL_VIDEO_CENTERED'] = '1'
        # Game Resolution
        self.__width = 1300
        self.__height = 700
        self.__offset = 800
        self.__screen = pygame.display.set_mode((self.__width, self.__height))
        # Screen color
        self.__screen.fill(self.__white)
        # Game Fonts
        self.__font = "PlayfairDisplay-Regular.otf"

        # GLOBAL VARIABLES
        self.__algorithmChosen = None
        self.__mapChosen = None


    # ----------------------------------------------------------------------------------------------------------------------
    # ----------------------------------------------------------------------------------------------------------------------
    # Text Renderer
    def text_format(self,message, textFont, textSize, textColor):
        newFont = pygame.font.Font(textFont, textSize)
        newText = newFont.render(message, 0, textColor)

        return newText

    # ----------------------------------------------------------------------------------------------------------------------
    # ----------------------------------------------------------------------------------------------------------------------
    def chooseAlgorithmMap(self,option,name=None):
        choice = False
        iterator = 0
        text = [None]*len(option)
        rect =  [None]*len(option)
        selected = option[iterator]
        self.__screen = pygame.display.set_mode((self.__width-self.__offset, self.__height))
        self.__screen.fill(self.__white)
        pygame.display.flip()
        while not choice:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    quit()
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_UP:
                        iterator = iterator - 1
                        if (iterator < 0): iterator = len(option)-1
                        selected = option[iterator]
                    elif event.key == pygame.K_DOWN:
                        iterator = iterator + 1
                        if (iterator >= len(option)): iterator = 0
                        selected = option[iterator]
                    if event.key == pygame.K_RETURN:
                        return name[iterator]


            if len(option) <= 6:
                size = 60
            else:
                size = 40

            for i in range(len(option)):
                if selected == option[i]:
                    text[i] = self.text_format(option[i], self.__font, size, self.__blue)
                else:
                    text[i] = self.text_format(option[i], self.__font, size, self.__black)

                rect[i] = text[i].get_rect()

                self.__screen.blit(text[i], ((self.__width-self.__offset) / 2 - (rect[i][2] / 2), (i)*(self.__height/len(option))))

            pygame.display.flip()


    # ----------------------------------------------------------------------------------------------------------------------
    # ----------------------------------------------------------------------------------------------------------------------
    # Main Menu
    def main_menu(self):
        choice = False
        iterator = 0
        option = ["chooseAlgorithm", "chooseMap", "quit"]
        selected = option[iterator]

        while self.__algorithmChosen == None or self.__mapChosen == None:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    quit()
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_UP:
                        iterator = iterator - 1
                        if (iterator < 0): iterator = len(option)-1
                        selected = option[iterator]
                    elif event.key == pygame.K_DOWN:
                        iterator = iterator + 1
                        if (iterator >= len(option)): iterator = 0
                        selected = option[iterator]
                    if event.key == pygame.K_RETURN:
                        if selected == option[0]:
                            self.__algorithmChosen = self.chooseAlgorithmMap(["BFS", "DFS", "GFS","A*","DIJKSTRA","RRT","BIDIRECTIONAL-RRT"],["BFS", "DFS", "GFS","A*","DIJKSTRA","RRT","BIDIRECTIONAL-RRT"])
                            self.__screen = pygame.display.set_mode((self.__width, self.__height))
                            self.__screen.fill(self.__white)
                            pygame.display.flip()
                        if selected == option[1]:
                            self.__mapChosen = self.chooseAlgorithmMap(["MAP 1","MAP 2","MAP 3","MAP 4","MAP 5","MAP 6","MAP 7","MAP 8","MAP 9","MAP 10","MAP 11","MAZE","MAP RRT"],
                                                          ["map1.csv","map2.csv","map3.csv","map4.csv","map5.csv","map6.csv","map7.csv","map8.csv","map9.csv","map10.csv","map11.csv","laberinto.csv","map_rrt.csv"])
                            self.__screen = pygame.display.set_mode((self.__width, self.__height))
                            self.__screen.fill(self.__white)
                            pygame.display.flip()
                        if selected == option[2]:
                            pygame.quit()
                            quit()
                            exit(1)

            # Main Menu UI
            title = self.text_format("Path Planning Algorithms", self.__font, 90, self.__black)
            subtitle = self.text_format("Sergio Masa - Julio Sanchez - Ignacio Arnanz", self.__font, 40, self.__red)

            if selected == option[0]:
                t1 = self.text_format("Choose Algorithm", self.__font, 60, self.__blue)
            else:
                t1 = self.text_format("Choose Algorithm", self.__font, 60, self.__black)

            if selected == option[1]:
                t2 = self.text_format("Choose Map", self.__font, 60, self.__blue)
            else:
                t2 = self.text_format("Choose Map", self.__font, 60, self.__black)

            if selected == option[2]:
                t3 = self.text_format("QUIT", self.__font, 60, self.__blue)
            else:
                t3 = self.text_format("QUIT", self.__font, 60, self.__black)

            title_rect = title.get_rect()
            subtitle_rect = subtitle.get_rect()

            rect1 = t1.get_rect()
            rect2 = t2.get_rect()
            rect3 = t3.get_rect()

            # Main Menu Text
            self.__screen.blit(title, (self.__width / 2 - (title_rect[2] / 2), 100))
            self.__screen.blit(subtitle, (self.__width / 2 - (subtitle_rect[2] / 2), 200))
            self.__screen.blit(t1, (self.__width / 2 - (rect1[2] / 2), 400))
            self.__screen.blit(t2, (self.__width / 2 - (rect2[2] / 2), 500))
            self.__screen.blit(t3, (self.__width / 2 - (rect3[2] / 2), 600))

            pygame.display.update()
            pygame.display.set_caption("Path Planning Algorithms")

    def get_algorithm(self):
        return self.__algorithmChosen
    def get_map(self):
        return self.__mapChosen
    def reset(self):
        self.__algorithmChosen = None
        self.__mapChosen = None


# ----------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------
def interactInterface(map_name):

        # Origin and destiny declaration.
    if map_name == '../Maps/map1.csv':
        origin = classes.Point(3, 3)
        destiny = classes.Point(8, 3)
        dimenssion = [30,30]
    elif map_name == '../Maps/map2.csv':
        origin = classes.Point(3, 3)
        destiny = classes.Point(11, 8)
        dimenssion = [30,30]
    elif map_name == '../Maps/map3.csv':
        origin = classes.Point(5, 11)
        destiny = classes.Point(5, 15)
        dimenssion = [25,25]
    elif map_name == '../Maps/map4.csv':
        origin = classes.Point(5, 15)
        destiny = classes.Point(5, 11)
        dimenssion = [20,20]
    elif map_name == '../Maps/map5.csv':
        origin = classes.Point(4, 16)
        destiny = classes.Point(4, 10)
        dimenssion = [20,20]
    elif map_name == '../Maps/map6.csv':
        origin = classes.Point(3, 3)
        destiny = classes.Point(11, 18)
        dimenssion = [25,25]
    elif map_name == '../Maps/map7.csv':
        origin = classes.Point(4, 10)
        destiny = classes.Point(4, 16)
        dimenssion = [20,20]
    elif map_name == '../Maps/map8.csv':
        origin = classes.Point(3, 3)
        destiny = classes.Point(11, 18)
        dimenssion = [20,20]
    elif map_name == '../Maps/map9.csv':
        origin = classes.Point(4, 10)
        destiny = classes.Point(4, 16)
        dimenssion = [20,20]
    elif map_name == '../Maps/map10.csv':
        origin = classes.Point(4, 10)
        destiny = classes.Point(4, 16)
        dimenssion = [20,20]
    elif map_name == '../Maps/map11.csv':
        origin = classes.Point(4, 16)
        destiny = classes.Point(4, 10)
        dimenssion = [20,20]
    elif map_name == '../Maps/laberinto.csv':
        origin = classes.Point(3, 3)
        destiny = classes.Point(26, 24)
    elif map_name == '../Maps/map_rrt.csv':
        origin = classes.Point(4, 16)
        destiny = classes.Point(4, 10)



    #----------------------------------------------------------------------------------------------------------------------
    #--------------------------------                BFS ALGORITHM              -------------------------------------------
    #----------------------------------------------------------------------------------------------------------------------
    if gui.get_algorithm() == "BFS":
        reachedPoint = app.bfs(origin, destiny,map_name)
    elif gui.get_algorithm() == "DFS":
        reachedPoint = app.dfs(origin, destiny,map_name)
    elif gui.get_algorithm() == "GFS":
        reachedPoint = app.gfs_complete(origin, destiny, map_name)
    elif gui.get_algorithm() == "A*":
        reachedPoint = app.a_star(origin, destiny, map_name)
    elif gui.get_algorithm() == "DIJKSTRA":
        reachedPoint = app.dijkstra(origin, destiny, map_name)
    elif gui.get_algorithm() == "RRT":
        reachedPoint = app.rrt(origin,destiny,map_name)        #Draw Road
    elif gui.get_algorithm() == "BIDIRECTIONAL-RRT":
        reachedPoint = app.bidirectional_rrt(origin,destiny,map_name)

    #Relaunch menu
    gui.initializeInterface()
    gui.main_menu()
    interactInterface('../Maps/' + str(gui.get_map()))


# MAIN
colours = [(0, 0, 0), (255, 255, 255), (255, 0, 0), (0, 255, 0),
           (30, 154, 255),(252, 191, 1),(50,50,50)]  # colors in the map, it's necessary five colours.
# Black      #White      #Red      #Green       #Blue    #darkRed #Gray
gui = GUI()
gui.main_menu()
map_name = '../Maps/' + str(gui.get_map())
interactInterface(map_name)






