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
      
    snake = new Snake(this);
    snake.initSnake(width / rectSize / 2,height / rectSize / 2);
    
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
    for(int xPar = 0; xPar < width/rectSize; xPar++)
      for(int yPar = 0; yPar < height/rectSize; yPar++) {
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
      x = int(random(1, width / rectSize - 2));
      y = int(random(1, height / rectSize - 2));
    } while(theGrid[x][y].type != "BG");
    
    setToFood(x,y);
  }
  
  boolean isClear(Position pos) {
    boolean clear = true;
    
    if(pos.x <= -1 || pos.x >= width / rectSize || pos.y <= -1 || pos.y >= height / rectSize)
      clear = false;
    else
      clear = theGrid[pos.x][pos.y].type == "BG" || theGrid[pos.x][pos.y].type == "FOOD";
    
    return clear;
  }
  
  boolean isFood(Position pos) {
    return theGrid[pos.x][pos.y].type == "FOOD";
  }
}