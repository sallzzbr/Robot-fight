class Hadouken {
  
  float x1 = 200;
  float velX=5;
  
  Hadouken() { 
    //fill(255);
    pushStyle();
    noFill();
    noStroke();
    x1+=velX;
    ellipseMode(CENTER);
    ellipse(x1, 300, 80, 80);
    image(hadou1, x1, 300, 100, 100);
    popStyle();
  
    if (x1 > width+50) {
      x1 = 200;   
      trigger1 = false;
    }
  }
  
  
}

