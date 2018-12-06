class Player {
  String player_number;
  PVector head_pos;
  PVector r_hand_pos;
  PVector l_hand_pos;
  PVector torso_pos;
  float life_update;
  float full_life = 1000;
  int life_x;
  String hands_side;
  float hadou_x_loc;
  //Hadouken[]hadoukens = new Hadouken[1];
  ArrayList<Hadouken>hadoukens;
  int hit;

  //float head_x, head_y;

  Player(String temp_player, PVector temp_head, PVector temp_torso, PVector temp_r_hand, PVector temp_l_hand) {   
    player_number = temp_player;
    head_pos = temp_head;
    torso_pos = temp_torso;
    r_hand_pos = temp_r_hand;
    l_hand_pos = temp_l_hand;
    hadoukens = new ArrayList();
    hit = 0;
  }

  //  Player(){
  //    
  //  }

  void run() {
    display();
    lifeBar();
    hadou_trigger();
    //move();
  }

  void display() {
    imageMode(CENTER); 
    //HEAD
    if (head_pos != null) { 
      if (hadoukens.size() == 1) {
        hadoukens.get(0).run();
      }     
      if (player_number == "p1") {
        image(head1, head_pos.x, head_pos.y, 100, 100);
      } else {
        image(head2, head_pos.x, head_pos.y, 100, 100);
      }
    } 
    //TORSO
    if (torso_pos != null) {
      if (player_number == "p1") {
        image(tronco1, torso_pos.x, torso_pos.y+50, 100, 250);
      } else {
        image(tronco2, torso_pos.x, torso_pos.y+50, 100, 250);
      }
    } 
    //HANDS
    if (r_hand_pos != null) {
      if (player_number == "p1") {
        image(maoD1, r_hand_pos.x, r_hand_pos.y, 35, 35);
      } else {
        image(maoD2, r_hand_pos.x, r_hand_pos.y, 35, 35);
      }
    } 
    if (l_hand_pos != null) {
      if (player_number == "p1") {
        image(maoE1, l_hand_pos.x, l_hand_pos.y, 35, 35);
      } else {
        image(maoE2, l_hand_pos.x, l_hand_pos.y, 35, 35);
      }
    }
  }

  //void move(){
  //    if(head_pos != null){
  //      head_x = head_pos.x;
  //      head_y = head_pos.y;
  //    }
  //}

  void hadou_trigger() {
    if (l_hand_pos != null && r_hand_pos != null) {
      if (hadoukens.size() < 1) {
        if (l_hand_pos.x > torso_pos.x && r_hand_pos.x > torso_pos.x) {
          println(hadoukens.size());
          hands_side = "left";
          hadou_x_loc = r_hand_pos.x;
          hadoukens.add(new Hadouken(hands_side, hadou_x_loc));
        } else if (l_hand_pos.x < torso_pos.x && r_hand_pos.x < torso_pos.x) {
          println(hadoukens.size());
          hands_side = "right";
          hadou_x_loc = r_hand_pos.x;
          hadoukens.add(new Hadouken(hands_side, hadou_x_loc));
        }
      } else {
        if (hadoukens.get(0).hado_x < 0 || hadoukens.get(0).hado_x > 640) {
          hadoukens.clear();
        }
      }
    }
  }

  void lifeBar() {
    if (player_number == "p1") {
      life_x = 60;
      fill(255, 30, 0);
    } else {
      life_x = 380;
      fill(30, 255, 0);
    }
    noStroke();
    life_update = map(full_life, 1000, 0, 200, 0);
    rect(life_x + 200, 30, -life_update, 30);
    strokeWeight(2);
    stroke(255);
    noFill();
    rect(life_x, 30, 200, 30);
  }

  void collision(Player other) {

    //if(players.size() == 2){
    if (other.torso_pos != null &&  head_pos != null && l_hand_pos != null && r_hand_pos != null) {
      if (other.full_life > 0) {
        if (other.l_hand_pos.y > other.head_pos.y && other.r_hand_pos.y > other.head_pos.y) {
          if(hit < 1){
            if ((l_hand_pos.x > other.torso_pos.x - 50 && l_hand_pos.x < other.torso_pos.x + 50) || (r_hand_pos.x > other.torso_pos.x - 50 && r_hand_pos.x < other.torso_pos.x + 50)) {
              if ((l_hand_pos.y > other.torso_pos.y - 75 && l_hand_pos.y < other.torso_pos.y + 175) || (r_hand_pos.y > other.torso_pos.y - 75 && r_hand_pos.y < other.torso_pos.y + 175)) {
                  other.full_life-=100;
                  hit++ ;
              }
            } 
            if (hadoukens.size() == 1) {
              if ((hadoukens.get(0).hado_x > other.torso_pos.x - 50 && hadoukens.get(0).hado_x < other.torso_pos.x + 50) || (hadoukens.get(0).hado_x > other.torso_pos.x - 50 && hadoukens.get(0).hado_x < other.torso_pos.x + 50)) {  
                  other.full_life-=100;
                  hit++ ;
              } 
            }
          }
        } else {
          if(frameCount%60 == 15){
            hit = 0;
            println("go");
          }
        }
    } 

    //        if (l_hand_pos.x > other.head_pos.x - 50 && l_hand_pos.x < other.head_pos.x + 50 || r_hand_pos.x > other.head_pos.x - 50 && r_hand_pos.x < other.head_pos.x + 50){
    //          other.full_life-=100; 
    //        }
  }

  //}
}

}
