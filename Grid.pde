class Grid {
  int rectSize = 20;
  Rectangle[][] theGrid = new Rectangle[int(width/rectSize)][int(height/rectSize)];
  void initGrid() {
    fill(0);
    
    for(int xPar = 0; xPar < width/rectSize; xPar++)
      for(int yPar = 0; yPar < height/rectSize; yPar++) {
        theGrid[xPar][yPar] = new Rectangle(xPar*rectSize, yPar*rectSize, rectSize, "BG");
        theGrid[xPar][yPar].draw();
      }
  }
}