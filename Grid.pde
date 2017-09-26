class Grid {
  Snake snake;
  int rectSize = 20;
  int xTileNo = int(width/rectSize);
  int yTileNo = int((height-40)/rectSize);
  Rectangle[][] theGrid = new Rectangle[xTileNo][yTileNo];
  TextManager tm = new TextManager();
  
  void initGrid() {
    fill(0);
    
    for(int xPar = 0; xPar < xTileNo; xPar++)
      for(int yPar = 0; yPar < yTileNo; yPar++) {
        theGrid[xPar][yPar] = new Rectangle(xPar*rectSize, yPar*rectSize+40, rectSize, "BG");
        theGrid[xPar][yPar].draw();
      }
      
    snake = new Snake(this);
    snake.initSnake(xTileNo / 2,yTileNo / 2);
    
    placeFood();
  } //initGrid
  
  void setToSnake(Position pos) {
    theGrid[pos.x][pos.y].setType("SNAKE");
  }
  
  void setToBG(Position pos) {
    theGrid[pos.x][pos.y].setType("BG");
  }
  
  void setToFood(int x, int y) {
    theGrid[x][y].setType("FOOD");
  }
  
  void setSnakeDir(String dir) {
    snake.setDirection(dir);
  }
  
  void update() {
    snake.update();
    for(int xPar = 0; xPar < xTileNo; xPar++)
      for(int yPar = 0; yPar < yTileNo; yPar++) {
        theGrid[xPar][yPar].draw();
      }
  }
  
  boolean isFoodTile(Position pos) {
    return theGrid[pos.x][pos.y].type == "FOOD";
  }
  
  void placeFood() {
    int x;
    int y;
    do {
      x = int(random(1, xTileNo - 2));
      y = int(random(1, yTileNo - 2));
    } while(theGrid[x][y].type != "BG");
    
    setToFood(x,y);
  }
  
  boolean isClear(Position pos) {
    boolean clear = true;
    
    if(pos.x < 0 || pos.x >= xTileNo || pos.y < 0 || pos.y >= yTileNo)
      clear = false;
    else
      clear = theGrid[pos.x][pos.y].type == "BG" || theGrid[pos.x][pos.y].type == "FOOD";
    
    return clear;
  }
  
  boolean isFood(Position pos) {
    return theGrid[pos.x][pos.y].type == "FOOD";
  }
  
  void message(String message) {
    tm.message(message);
  }
  
  void score(int score) {
    tm.updateScore(score);
  }
}