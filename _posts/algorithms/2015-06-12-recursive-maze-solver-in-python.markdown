---
layout: post
title: Recursive Maze Solver in Python
date: 2015-06-12T14:39:54-05:00
---
When I was asked to make a program for solving a maze during the job interview for some reason I simply attempted to model a known human-friendly heuristics: follow the right wall. The [resulting code]({% post_url /algorithms/2015-02-28-Maze-Solver-Java %}) was very long and somewhat hard although worked alright. 

Now, during the algorithms class and review of DFS I decided to try the recursive approach for solving the maze.
For starters let us create one: 

{% highlight python linenos %}
# 0 clear
# 1 wall
# 2 was here
# 8 start
# 9 finish
maze = [
        [0, 0, 1, 0, 1],
        [0, 1, 0, 0, 0],
        [0, 1, 0, 1, 0],
        [0, 0, 0, 1, 0],
        [1, 1, 1, 0, 9]
]
{% endhighlight %}

Alternatively, we can feed the following txt file:
{% highlight python linenos %}
+--+--+--+--+--+--+--+--+--+--+
|             S|     |     |  |
+  +--+--+--+  +--+  +  +  +  +
|     |  |     |     |  |  |  |
+--+  +  +  +--+  +--+--+  +  +
|     |  |        |     |     |
+  +--+  +--+--+--+  +  +  +--+
|     |        |     |        |
+--+  +--+  +  +  +--+--+--+  +
|  |  |  |  |     |           |
+  +  +  +  +--+--+  +--+--+--+
|           |     |        |  |
+--+  +--+--+  +--+--+--+  +  +
|     |        |     |     |  |
+  +--+  +--+  +  +--+  +--+  +
|  |     |  |  |     |      F |
+  +  +--+  +  +--+  +--+--+  +
|  |  |     |     |  |     |  |
+  +  +  +--+--+  +  +  +--+  +
|     |              |        |
+--+--+--+--+--+--+--+--+--+--+
{% endhighlight %}

Which could be elegantly parsed into created above format:
{% highlight python linenos %}
def readMaze(filename):
    maze_mapping = {'S' : 0, 'F' : 9, ' ' : 0, '+' : 1, '-' : 1, '|' : 1}
    return [[maze_mapping[char] for char in line[:-1]] for line in open(filename)]
{% endhighlight %}

Now we need to know the properties of the maze and print it. For later I used tabulate package to print a list of lists as a table:
{% highlight python linenos %}
from tabulate import tabulate
width = len(maze)
height = len(maze[0])
print 'Maze width: %s, height %s' % (width, height)
{% endhighlight %}

Finally, the recursive function. The idea is simple: try to go in every direction recursively and if no wall, no out of bounds and was not here before - move on!
{% highlight python linenos %}
def move(x, y):
    global FoundWayOut
    if FoundWayOut:
        return

    print tabulate(maze)

    if (x < 0 or x > width - 1 or y < 0 or y > height - 1):
        print 'Out of bounds'; return
    if (maze[x][y] == 9):
        FoundWayOut = True
        print 'Got it!'; return
    if (maze[x][y] == 1):
        print 'That is wall'; return
    if (maze[x][y] == 2):
        print 'Was here before'; return
    maze[x][y] = 2

    move(x + 1, y) # East
    move(x, y + 1) # South
    move(x - 1, y) # West
    move(x, y - 1) # North
{% endhighlight %}

Now we can find the way out of the maze (if there is a way out):
{% highlight python linenos %}
move(0, 0)
if not FoundWayOut:
    print 'There is no way out of this!'
{% endhighlight %}

First call should be made from the start position.

Overall, recursive solution is way more elegant and easier to grasp as well as to implement. 