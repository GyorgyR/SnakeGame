class TextManager {
  int rectSize = 40;
  TextManager() {
    clear(0, width / rectSize);
    fill(20);
    textSize(24);
    text("Score: 0", 10, 30);
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
}