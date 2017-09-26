class List {
  Position[] poses;
  int noOfItemsIn;
  
  List(int size) {
    poses = new Position[size];
    noOfItemsIn = 0;
  }
  
  Position get(int index) {
    return poses[index];
  }
  
  void add(Position pos) {
    noOfItemsIn++;
    if(noOfItemsIn == poses.length) {
      Position[] biggerArray = new Position[noOfItemsIn * 2];
      for(int i = 0; i < poses.length; i++) {
        biggerArray[i] = poses[i];
      }
      poses = biggerArray;
    }
    poses[noOfItemsIn-1] = pos;
  }
  
  void add(int index, Position pos) {
    if(index < noOfItemsIn) {
      poses[index] = pos;
    }
  }
  
  int size() {
    return noOfItemsIn;
  }
}