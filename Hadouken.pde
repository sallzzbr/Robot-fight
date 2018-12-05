class Hadouken {
  
  String side;
  float hado_x;
  float velX;
  float accel;
  
  Hadouken(String temp_side, float temp_hado_x){
    side = temp_side;
    hado_x = temp_hado_x;
    velX = 3;
    accel = 1.1;
  }
  
  void run(){
    display();
    move();
  }
  
  void display(){
    if(side == "left"){
      image(hadou1, hado_x, 150, 100, 100);
    } else {
      image(hadou2, hado_x, 150, 100, 100);
    }
  }
  
  void move(){
    velX = velX * accel;
    if(side == "left"){
      hado_x += velX;
    } else {
      hado_x -= velX;
    }
  }
  
}
