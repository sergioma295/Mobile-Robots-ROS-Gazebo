import Queue
from MODULOS import algorithms, classes
import time

def bfs(origin,destiny,name):

    q = Queue.Queue()
    q.put(origin)
    algorithm = algorithms.algorithms(name)
    start = time.time()
    reachedPoint = algorithm.bfs(q,origin,destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    algorithm.plot_road(origin,reachedPoint)


def dfs(origin,destiny,name):
    q=[]
    q.append(origin)
    algorithm = algorithms.algorithms(name)
    start = time.time()
    reachedPoint=algorithm.dfs(q,origin,destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    algorithm.plot_road(origin,reachedPoint)

def gfs_complete(origin,destiny,name):
    q = classes.PriorityQueue()
    q.insert(origin)
    algorithm= algorithms.algorithms(name)
    start = time.time()
    reachedPoint=algorithm.gfs_complete(q,origin,destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    algorithm.plot_road(origin,reachedPoint)

def gfs_incomplete(origin,destiny,name):
    q = classes.PriorityQueue()
    q.insert(origin)
    algorithm= algorithms.algorithms(name)
    start = time.time()
    reachedPoint=algorithm.gfs_incomplete(q,origin,destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.plot_road(origin,reachedPoint)

def a_star(origin,destiny, name):
    algorithm = algorithms.algorithms(name)
    start = time.time()
    reachedPoint=algorithm.a_star(origin,destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    algorithm.plot_road(origin, reachedPoint)

def dijkstra(origin,destiny,name):
    algorithm = algorithms.algorithms(name)
    start = time.time()
    reachedPoint = algorithm.dijkstra(origin, destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    algorithm.plot_road(origin, reachedPoint)

def rrt(origin, destiny, name):
    algorithm = algorithms.algorithms(name)
    start = time.time()
    rrt = algorithm.rrt(origin, destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start - rrt[2]))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    reachedPoint=rrt[0]
    if rrt[1]:
        algorithm.plot_road_rrt(origin, destiny, reachedPoint)

def bidirectional_rrt(origin, destiny, name):
    algorithm = algorithms.algorithms(name)
    start = time.time()
    rrt_bidirectional = algorithm.bidirectional_rrt(origin, destiny)
    end = time.time()
    print("Tiempo(s) = " + str(end - start))
    print("Nodos explorados = " + str(algorithm.get_num_nodes()))
    algorithm.reset_nodes()
    if rrt_bidirectional[2]:
        algorithm.plot_road_bidirectional_rrt(origin, destiny, rrt_bidirectional[0],rrt_bidirectional[1])

def simple_rrt(name):
    algorithm= algorithms.algorithms(name)
    algorithm.simple_rrt()
