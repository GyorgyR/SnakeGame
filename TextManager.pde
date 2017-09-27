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
  
  void updateScore(int score) {
    clear(0,width / rectSize / 2);
    fill(20);
    textSize(24);
    textAlign(LEFT);
    text("Score: " + score, 10, 30);
  }
  
  void message(String message) {
    clear(width / rectSize / 2, width / rectSize);
    fill(20);
    textSize(24);
    textAlign(RIGHT);
    text(message, width - 10, 30);
  }
  
  void clear(int start, int stop) {
    fill(225);
    for(int index = start; index < stop; index++) {
      noStroke();
      rect(index*rectSize, 0, rectSize, rectSize);
    }
  }
  
  void textBox() {
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
    +" will be a new obstacle (green tile).\n"
    +"After every 20th score the game\n"
    +"will be faster";
    
    text(description,xStart*4, yStart + 250);
    
    textSize(32);
    text("Good luck! :)",xStart*4, yStart+430);
  }
}