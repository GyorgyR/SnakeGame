import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SnakeGame extends PApplet {

Grid grid;
static boolean isRunning;
int fRate = 8;

public void setup() {
  
  frameRate(fRate);
  isRunning = false;
  grid = new Grid();
  grid.initGrid();
  grid.message("Press s to start!");
}

public void draw() {
  if(keyPressed == true) {
    //isRunning = true;
  }
  if(isRunning) {
    grid.update();
  }
}

public void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP)
      grid.setSnakeDir("UP");
    else if(keyCode == DOWN)
      grid.setSnakeDir("DOWN");
    else if(keyCode == LEFT)
      grid.setSnakeDir("LEFT");
    else if(keyCode == RIGHT)
      grid.setSnakeDir("RIGHT");
  }
  else if(key == 's') {
    grid.message("START!");
    isRunning = true;
  }
  else if(key == 'r') {
    setup();
  }
  
  else if(key == 'q') {
    System.exit(0);
  }
  
  else if(key == 'p') {
    isRunning = !isRunning;
  }
}
class Grid {
  Snake snake;
  
  int rectSize = 20;
  int xTileNo = PApplet.parseInt(width/rectSize);
  int yTileNo = PApplet.parseInt((height-40)/rectSize);
  
  Rectangle[][] theGrid = new Rectangle[xTileNo][yTileNo];
  
  TextManager tm = new TextManager();
  
  public void initGrid() {
    
    for(int xPar = 0; xPar < xTileNo; xPar++)
      for(int yPar = 0; yPar < yTileNo; yPar++) {
        theGrid[xPar][yPar] = new Rectangle(xPar*rectSize, yPar*rectSize+40, rectSize, "BG");
        theGrid[xPar][yPar].draw();
      }
      
    snake = new Snake(this);
    snake.initSnake(xTileNo / 2,yTileNo / 2);
    
    placeFood();
    placeObstacle();
    tm.textBox();
  } //initGrid
  
  public void setToSnake(Position pos) {
    theGrid[pos.x][pos.y].setType("SNAKE");
  }
  
  public void setToBG(Position pos) {
    theGrid[pos.x][pos.y].setType("BG");
  }
  
  public void setToFood(int x, int y) {
    theGrid[x][y].setType("FOOD");
  }
  
  public void setSnakeDir(String dir) {
    snake.setDirection(dir);
  }
  
  public void update() {
    snake.update();
    for(int xPar = 0; xPar < xTileNo; xPar++)
      for(int yPar = 0; yPar < yTileNo; yPar++) {
        theGrid[xPar][yPar].draw();
      }
  }
  
  public boolean isFoodTile(Position pos) {
    return theGrid[pos.x][pos.y].type == "FOOD";
  }
  
  public void placeFood() {
    int x;
    int y;
    do {
      x = PApplet.parseInt(random(1, xTileNo - 2));
      y = PApplet.parseInt(random(1, yTileNo - 2));
    } while(theGrid[x][y].type != "BG");
    
    setToFood(x,y);
  }
  
  public void placeObstacle() {
    int x;
    int y;
    
    do {
      x = PApplet.parseInt(random(1, xTileNo - 2));
      y = PApplet.parseInt(random(1, yTileNo - 2));
    } while(theGrid[x][y].type != "BG");
    
    theGrid[x][y].type = "OBSTACLE";
  }
  
  public boolean isClear(Position pos) {
    boolean clear = true;
    
    if(pos.x < 0 || pos.x >= xTileNo || pos.y < 0 || pos.y >= yTileNo)
      clear = false;
    else
      clear = theGrid[pos.x][pos.y].type == "BG" || theGrid[pos.x][pos.y].type == "FOOD";
    
    return clear;
  }
  
  public boolean isFood(Position pos) {
    return theGrid[pos.x][pos.y].type == "FOOD";
  }
  
  public void message(String message) {
    tm.message(message);
  }
  
  public void score(int score) {
    tm.updateScore(score);
    
    if(score % 20 == 0)
      frameRate(frameRate + 2);
  }
}
class List {
  Position[] poses;
  int noOfItemsIn;
  
  List(int size) {
    poses = new Position[size];
    noOfItemsIn = 0;
  }
  
  public Position get(int index) {
    return poses[index];
  }
  
  public void add(Position pos) {
    noOfItemsIn++;
    if(noOfItemsIn == poses.length) {
      Position[] biggerArray = new Position[noOfItemsIn * 2];
      for(int i = 0; i < poses.length; i++) {
        biggerArray[i] = poses[i];
      }
      poses = biggerArray;
    }
    poses[noOfItemsIn-1] = pos;
  }
  
  public void add(int index, Position pos) {
    if(index < noOfItemsIn) {
      poses[index] = pos;
    }
  }
  
  public int size() {
    return noOfItemsIn;
  }
}
class Position {
  int x;
  int y;
  
  Position(int _x,int _y) {
    x = _x;
    y = _y;
  }
  
  Position(Position other) {
   x = other.x;
   y = other.y;
  }
}
class Rectangle {
   float x;
   float y;
   int size;
   
   //should be enum
   String type;
   
   Rectangle(float _x, float _y, int _size, String _type) {
     x = _x;
     y = _y;
     size = _size;
     type = _type;
   }
   public void draw() {
     if(type == "BG")
       fill(30);
     else if(type == "SNAKE")
       fill(230);
     else if(type == "FOOD")
       fill(160,70,210);
     else if(type == "OBSTACLE")
       fill(80,160,90);
     else
       println(type);
       
     noStroke();
     rect(x,y,size,size); 
   } //draw
   
   public void setType(String _type) {
     type = _type;
   }
}
class Snake {
  String direction;
  Grid grid;
  int size = 2;
  List pos;
  int score = 0;
  
  
  Snake(Grid _grid) {
    grid = _grid;
    pos = new List(size);
  } //Snake
  
  public void initSnake(int x, int y) {
    Position headPos = new Position(x,y);
    Position tailPos = new Position(x-1,y);
    
    direction = "RIGHT";
    
    grid.setToSnake(headPos);
    pos.add(headPos);
    grid.setToSnake(tailPos);
    pos.add(tailPos);
  } //initSnake
  
  public void update() {
    Position prevTailPos = new Position(pos.get(pos.size()-1));
    int xChange = 0, yChange = 0;
    
    switch(direction) {
      case "RIGHT":
        xChange = 1;
        break;
      case "LEFT":
        xChange = -1;
        break;
      case "UP":
        yChange = -1;
        break;
      case "DOWN":
        yChange = 1;
        break;
    }
    
    for(int i = pos.size()-1; i > 0 ; i--)
      pos.add(i,new Position(pos.get(i-1)));
    
    pos.get(0).x += xChange;
    pos.get(0).y += yChange;
    
    if(grid.isClear(pos.get(0))) {
      if(!grid.isFood(pos.get(0))) {
        grid.setToBG(prevTailPos);
      }
      else {
        size++;
        score++;
        grid.score(score);
        pos.add(new Position(prevTailPos));
        grid.placeFood();
      }
      grid.setToSnake(pos.get(0));
    }
    else
      //grid.setToSnake(pos[0]);
      die();
  }
  
  public void die() {
    SnakeGame.isRunning = false;
    grid.message("YOU DIED! Press 'r' to restart.");
    //println("x: "+pos.get(0).x + ", y: "+pos.get(0).y);
  }
  
  public void setDirection(String d) {
    if(d != direction) {
      boolean canChange = true;
      switch(direction) {
       case "LEFT":
         if(d == "RIGHT") {
           canChange = false;
         }
         break;
       case "RIGHT":
         if(d == "LEFT") {
           canChange = false;
         }
         break;
       case "UP":
         if(d == "DOWN") {
           canChange = false;
         }
         break;
       case "DOWN":
         if(d == "UP") {
           canChange = false;
         }
         break;
       
      }
      if(canChange)
        direction = d;
      else
        grid.message("Can't do that!");
    }
  }
  
}
class TextManager {
  int rectSize = 40;
  TextManager() {
    clear(0, width / rectSize);
    fill(20);
    textSize(24);
    textAlign(LEFT);
    text("Score: 0", 10, 30);
    textBox();
  }
  
  public void updateScore(int score) {
    clear(0,width / rectSize / 2);
    fill(20);
    textSize(24);
    textAlign(LEFT);
    text("Score: " + score, 10, 30);
  }
  
  public void message(String message) {
    clear(width / rectSize / 2, width / rectSize);
    fill(20);
    textSize(24);
    textAlign(RIGHT);
    text(message, width - 10, 30);
  }
  
  public void clear(int start, int stop) {
    fill(225);
    for(int index = start; index < stop; index++) {
      noStroke();
      rect(index*rectSize, 0, rectSize, rectSize);
    }
  }
  
  public void textBox() {
    int xStart = width / 8;
    int yStart = (height - 40) / 8 + 40;
    
    fill(210);
    rect(xStart, yStart, xStart*6, xStart*6);
    
    fill(25);
    textAlign(CENTER);
    textSize(40);
    text("Welcome to Snake!", xStart*4, yStart + 50);
    
    textSize(28);
    String keys = 
    "Press 's' to start the game.\n"
    +"Press 'q' at any time to exit.\n"
    +"Press 'r' to restart the game.";
    
    text(keys,xStart*4,yStart + 100);
    
    textSize(24);
    String description =
    "After every 10th score there\n"
    +" will be a new obstacle.\n"
    +"After every 20th score the game\n"
    +"will be faster";
    
    text(description,xStart*4, yStart + 250);
    
    textSize(32);
    text("Good luck! :)",xStart*4, yStart+430);
  }
}
  public void settings() {  size(600,640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SnakeGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
