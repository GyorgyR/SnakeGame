class Rectangle {
   float x;
   float y;
   int size;
   
   //should be enum
   String type;
   
   Rectangle(float _x, float _y, int _size, String _type) {
     x = _x;
     y = _y;
     size = _size;
     type = _type;
   }
   void draw() {
     if(type == "BG")
       fill(30);
     else if(type == "SNAKE")
       fill(230);
     else if(type == "FOOD")
       fill(30,60,80);
     else
       println(type);
       
     noStroke();
     rect(x,y,size,size); 
   }
}