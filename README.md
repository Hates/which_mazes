# Which Mazes

## Exercise Outline

Build a Rails application that generates and solves a Maze. You will be assessed primarily on your:

* Testing approach
* Solution design
* Code quality

We are keen to see your thought process and approach rather than the complete implementation.

## Introduction

Off the bat I should disclose that I *do not* know any maze generation or solving algorithms off the top of my head. But I shall still have a crack and see what I come up using. I will show any resources I have used during the process to arrive at my final applications.

## Initial thoughts and notes

* As the outline asks for a rails application, I assume that there should be some use of `ActiveRecord` in the project and that there should be some output of mazes and their solutions.
* Generating a maze and solving a maze should be delegated to some form of service object.
* Maze generation and solving algorithms should be interchangeable.

## Maze generation

The main algorith used a lot appears to the recursive backtracker algorithm. The outline from Wikipedia is as follows:

```
Make the initial cell the current cell and mark it as visited
While there are unvisited cells
	If the current cell has any neighbours which have not been visited
		Choose randomly one of the unvisited neighbours
		Push the current cell to the stack
		Remove the wall between the current cell and the chosen cell
		Make the chosen cell the current cell and mark it as visited
	Else if stack is not empty
		Pop a cell from the stack
		Make it the current cell
```

Most implementations use bitwise operations to keep a track of the paths but I would like to have an actual `Cell` model to represent the individual cells of a maze. While this can all be done in memory without the need to store the data, as the outline asks for a rails app I will store the actual mazes in the database.

Resources:

[https://en.wikipedia.org/wiki/Maze_generation_algorithm](https://en.wikipedia.org/wiki/Maze_generation_algorithm)  
[http://weblog.jamisbuck.org/2010/12/27/maze-generation-recursive-backtracking](http://weblog.jamisbuck.org/2010/12/27/maze-generation-recursive-backtracking)  
[https://www.youtube.com/watch?v=elMXlO28Q1U](https://www.youtube.com/watch?v=elMXlO28Q1U)

## Maze solving

Easiest solution seems to be a wall follower. As the generator used is simply connected this appears to be the quickest to attmpt to implement.

[https://en.wikipedia.org/wiki/Maze_solving_algorithm](https://en.wikipedia.org/wiki/Maze_solving_algorithm)