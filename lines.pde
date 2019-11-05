
class Wake {
  float lineLength;
  float lineLengths;

  int speed = 7;
  float startX;
  float endX;
  float y;
  boolean go=false;

  Wake(float tempStart, float tempLineLength, float tempY) {
    lineLength=tempStart+tempLineLength;
    startX=tempStart;
    y=tempY;
  }
  void display() {
    if (go==false) {

      line(startX=startX+speed, y, lineLength=lineLength+speed, y);
      
      if (lineLength>=rigth) {
        go=true;
        s++;
        s++;
      }
    }
    if (go==true) {

      line(startX=startX-speed, y, lineLength=lineLength-speed, y);
      if (startX<=width/4) {
        go=false;
        s--;
        s--;
      }
    }
  }

  void go()
  {
  }
}
