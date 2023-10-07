#implements heap queue
import heapq

#tuple that represents dimensions of the maze
maze_size = (5,9)
#tuples representing the coordinates of the barriers in the maze 
barriers = [(1, 8), (2, 2), (2, 4), (2, 5), (3, 4), (3, 7), (3, 9), (4, 4), (4, 7), (4, 9), (5, 2)]

#checks if the location is within the maze bounds
def v_move(x, y):
    return 0 <= x <= maze_size[0] and 0 <= y <= maze_size[1]

#uses heuristic A* algo (calc. the sum of the absolute differences between two points)
def heuristic(location, To):
    return abs(location[0] - To[0]) + abs(location[1] - To[1])

#This is the main fuction for finding the path
#From - list representing the start point
#To   - list representing the end point
#Path - optimal list to keep track of the path taken
def solve(From, To, Path = []):
    #converted to tuples and stored into varaibles of the same name
    From = tuple(From)
    To = tuple(To)

    #priority queue with tuple of cost 0 and starting point
    queue = [(0, From)]
    #dictionary that keeps track of the cost of reaching each location 
    cost = {From: 0}
    #dictionary that keeps track of the parent of each location, starting points parent set to None
    parent = {From: None}
    #set to keept track of locations that have been visited
    visited = set()

    #loops until queue is empty
    while queue:
        #first item is stored in both variables
        current_cost, current = heapq.heappop(queue)
        #path is found 
        if current == To:
            #list is created by tracing the parent of each location back to the starting point
            path = []
            while current:
                path.append(current)
                current = parent[current]
            #reversed and returned
            return path[::-1]
        if current in visited:
            continue

        #adds current to visited 
        visited.add(current)

        #list coordinating the four neighboring points 
        neighbors = [(current[0] + dx, current[1] + dy) for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]]

        
        for neighbor in neighbors:
            #checks if its valid location and not a barrier
            #if move is valid new cost = current cost + cost of moving (from current to neighbor)
            if v_move(*neighbor) and neighbor not in barriers:
                new_cost = cost[current] + 1

                #if neighbor has not been seen before or if new cost is lower than the previous cost
                #the cost of the parent of the neighbor are updated
                #a tuple of the priority and neighbor is pushed onto the queue
                if neighbor not in cost or new_cost < cost[neighbor]:
                    cost[neighbor] = new_cost
                    parent[neighbor] = current
                    priority = new_cost + heuristic(neighbor, To)
                    heapq.heappush(queue, (priority, neighbor))
    
    #no path found
    return []

print(solve([3, 1], [2, 6]))
print(solve([3, 1], [5, 9]))

