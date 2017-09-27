Grid grid;
static boolean isRunning;
int fRate = 6;

void setup() {
  size(600,640);
  frameRate(fRate);
  isRunning = false;
  grid = new Grid();
  grid.initGrid();
  grid.message("Press s to start!");
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