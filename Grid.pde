class Grid {
  Snake snake;
  int rectSize = 20;
  Rectangle[][] theGrid = new Rectangle[int(width/rectSize)][int(height/rectSize)];
  void initGrid() {
    fill(0);
    
    for(int xPar = 0; xPar < width/rectSize; xPar++)
      for(int yPar = 0; yPar < height/rectSize; yPar++) {
        theGrid[xPar][yPar] = new Rectangle(xPar*rectSize, yPar*rectSize, rectSize, "BG");
        theGrid[xPar][yPar].draw();
      }
      
    snake = new Snake(this, rectSize);
    snake.initSnake(width / rectSize / 2,height / rectSize / 2);
    
    placeFood();
  } //initGrid
  
  void setToSnake(int x, int y) {
    theGrid[x][y].setType("SNAKE");
  }
  
  void setToBG(int x, int y) {
    theGrid[x][y].setType("BG");
  }
  
  void setToFood(int x, int y) {
    theGrid[x][y].setType("FOOD");
  }
  
  void setSnakeDir(String dir) {
    snake.setDirection(dir);
  }
  
  void update() {
    snake.update();
    for(int xPar = 0; xPar < width/rectSize; xPar++)
      for(int yPar = 0; yPar < height/rectSize; yPar++) {
        theGrid[xPar][yPar].draw();
      }
  }
  
  boolean isFoodTile(int x, int y) {
    return theGrid[x][y].type == "FOOD";
  }
  
  void placeFood() {
    int x = int(random(1, width / rectSize - 2));
    int y = int(random(1, height / rectSize - 2));
    
    setToFood(x,y);
  }
  
  boolean isClear(int x, int y) {
    boolean clear = true;
    
    if(x <= 0 || x >= width / rectSize -1 || y <= 0 || y >= height / rectSize -1)
      clear = false;
    else
      clear = theGrid[x][y].type != "SNAKE";
    
    return clear;
  }
  
  boolean isFood(int x, int y) {
    return theGrid[x][y].type == "FOOD";
  }
  
  void moveSnakeParts(int xChange, int yChange) {
    for(int x = 0; x < width / rectSize; x++)
      for(int y = 0; y < height / rectSize; y++)
        if(theGrid[x][y].type == "SNAKE") {
          setToSnake(x + xChange, y + yChange);
        }
  }
}