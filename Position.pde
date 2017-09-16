class Position {
  int x;
  int y;
  
  Position(int _x,int _y) {
    x = _x;
    y = _y;
  }
  
  Position(Position other) {
   x = other.x;
   y = other.y;
  }
}