Grid grid;
static boolean isRunning;

void setup() {
  size(600,640);
  frameRate(8);
  isRunning = false;
  grid = new Grid();
  grid.initGrid();
}

void draw() {
  if(keyPressed == true) {
    //isRunning = true;
  }
  if(isRunning) {
    grid.update();
  }
}

void keyPressed() {
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
    println("START!");
    isRunning = true;
  }
  else if(key == 'r') {
    setup();
  }
}