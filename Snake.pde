class Snake {
  String direction;
  Grid grid;
  int rectSize;
  int headX, headY;
  int tailX, tailY;
  
  Snake(Grid _grid, int _rectSize) {
    grid = _grid;
    rectSize = _rectSize;
  } //Snake
  
  void initSnake(int x, int y) {
    headX = tailX = x;
    headY = tailY = y;
    
    direction = "RIGHT";
    
    grid.setToSnake(headX,headY);
  } //initSnake
  
  void update() {    
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
    
    headX += xChange;
    headY += yChange;
    if(grid.isClear(headX, headY)) {
      if(!grid.isFood(headX, headY)) {
        grid.setToBG(tailX, tailY);
        tailX += xChange;
        tailY += yChange;
      }
      grid.setToSnake(headX, headY);
    }
    else
      //grid.setToSnake(headX,headY);
      die();
  }
  
  void die() {
    SnakeGame.isRunning = false;
    println("YOU DIED!");
  }
  
  void setDirection(String d) {
    if(d != direction) {
      boolean canChange = true;
      switch(direction) {
       case "LEFT":
         if(d == "RIGHT") {
           println("Can't do that!");
           canChange = false;
         }
         break;
       case "RIGHT":
         if(d == "LEFT") {
           println("Can't do that!");
           canChange = false;
         }
         break;
       case "UP":
         if(d == "DOWN") {
           println("Can't do that!");
           canChange = false;
         }
         break;
       case "DOWN":
         if(d == "UP") {
           println("Can't do that!");
           canChange = false;
         }
         break;
       
      }
      if(canChange)
        direction = d;
    }
  }
  
}