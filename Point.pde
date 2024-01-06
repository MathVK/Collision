class Point{
  float x,y,z;
  Point(float x,float y, float z){
    this.x=x;
    this.y=y;
    this.z=z;
  }

  void add(Point p){
    this.x += p.x;
    this.y += p.y;
    this.z += p.z;
  }
}