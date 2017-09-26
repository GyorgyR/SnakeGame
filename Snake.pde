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
  
  void initSnake(int x, int y) {
    Position headPos = new Position(x,y);
    Position tailPos = new Position(x-1,y);
    
    direction = "RIGHT";
    
    grid.setToSnake(headPos);
    pos.add(headPos);
    grid.setToSnake(tailPos);
    pos.add(tailPos);
  } //initSnake
  
  void update() {
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
        println("Score: " + score);
        pos.add(new Position(prevTailPos));
        grid.placeFood();
      }
      grid.setToSnake(pos.get(0));
    }
    else
      //grid.setToSnake(pos[0]);
      die();
  }
  
  void die() {
    SnakeGame.isRunning = false;
    println("YOU DIED!");
    println("Score: " + score);
    //println("x: "+pos.get(0).x + ", y: "+pos.get(0).y);
  }
  
  void setDirection(String d) {
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