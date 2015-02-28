---
layout: post
title: Maze Solver in Java
---
Really nice way to check a potential candidate problem-solving skills is to test him as a mouse. 
How to find the way out of the maze? Programmically, of course.

From life experience we know, that the simpliest way to get out is to follow the right side 
and eventually we will find the exit.

Here is an example of the maze:
{% highlight java linenos %}
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

The goal is to start from S and find F. Here is a possible solution:

{% highlight java linenos %}
package salo.baylor.edu;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

class coord{
	public int i;
	public int j;
	public coord(int i, int j){
		this.i = i;
		this.j = j;
	}
}

//Directions: 1 - right, 2 - up, 3 - left, 4 - down

public class Maze_solver {
	static String route = "";
	static int last_move_direction = 2; //guess first direction
	static int[] directions = new int[]{4,1,2,3,4,1,2,3,4};	
	static boolean foundWayOut = false;
	@SuppressWarnings("serial")
	static HashMap<Integer, Character> direction_letters = new HashMap<Integer, Character>() {{
		put(1, 'r');
		put(2, 'u');
		put(3, 'l');
		put(4, 'd');
	}};
	                                  
	public static void main(String[] args) throws FileNotFoundException {
		String maze_filename = "maze.txt";
		char[][] maze = readMaze(maze_filename);
		printMaze(maze);
		getOut(maze);
	}
	
	private static char[][] readMaze(String filename) throws FileNotFoundException{
		Scanner sc = new Scanner(new BufferedReader(new FileReader(filename)));
		ArrayList<String> input = new ArrayList<String>();
		while (sc.hasNext())
			input.add(sc.nextLine());
		sc.close();
		
		int width = input.get(0).length(); 
		int height = input.size();		
		char[][] maze = new char[height][width];
		
		for (int j=0; j<height; j++){
			String line = input.get(j);
			for (int i=0; i < width; i++){
				maze[j][i] = line.charAt(i);
			}
		}
		
		return maze;
	}
	
	private static void printMaze(char[][] maze){
		for (int i=0; i < maze.length; i++){
			for (int j=0; j < maze[0].length; j++){
				System.out.print((char)maze[i][j]);
				System.out.print(" ");
			}
			System.out.println();
		}
	}
	
	private static void getOut(char[][] maze){
		coord coord = findStart(maze);
	    while (!foundWayOut){
	    	coord = makeMove(maze, coord);
	    	printMaze(maze);
	    }
		System.out.println(route);
	}
	
	static coord move(coord coord, int direction){
        coord new_coord = new coord(coord.i, coord.j);
        switch (direction){
        	case 1:
        		new_coord.j++;
        		break;
        	case 2:
        		new_coord.i--;
        		break;
        	case 3:
        		new_coord.j--;
        		break;
        	case 4:
        		new_coord.i++;
        		break;
        }        
        return new_coord;
    }
	
    static boolean checkIfGoodState(char[][] maze, coord coord){
    	if (maze[coord.i][coord.j] == 'F')
    		foundWayOut = true;
        return (maze[coord.i][coord.j] == ' ') ? true : false;
    }
    
    static coord makeMove(char[][] maze, coord coord){
        //try to do moves according to priority and break  
    	coord new_coord = null;
    	for (int i = last_move_direction - 1; i <= last_move_direction + 3; i++){
    		new_coord = move(coord, directions[i]);
    		if (checkIfGoodState(maze, new_coord)){
    			last_move_direction = directions[i];
    		    route += direction_letters.get(directions[i]);
    		    maze[new_coord.i][new_coord.j] = 'S';
    		    maze[coord.i][coord.j] = ' ';
    		    return new_coord;
    		}
    	}  		        
        return null; //shouldnt happen by assumption
    }
    
    static coord findStart(char[][] maze){
    	coord coord = new coord(0, 0);
        for (int i = 0; i < maze.length; i ++){
            for (int j = 0; j < maze[1].length; j ++){
               if (maze[i][j] == 'S'){
            	   coord.i = i;
            	   coord.j = j;
                   break;
               }
            }
        }
        return coord;
    }
}

{% endhighlight %}
