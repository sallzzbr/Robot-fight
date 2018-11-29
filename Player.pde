class Player {
  
  String player_number;
  PVector head_pos;
  PVector r_hand_pos;
  PVector l_hand_pos;
  PVector torso_pos;
  
  float head_x, head_y;
  
  Player(String temp_player, PVector temp_head, PVector temp_torso, PVector temp_r_hand, PVector temp_l_hand){   
    player_number = temp_player;
    head_pos = temp_head;
    torso_pos = temp_torso;
    r_hand_pos = temp_r_hand;
    l_hand_pos = temp_l_hand;    
  }

//  Player(){
//    
//  }
  
  void run(){
    display();
    //move();
  }
  
  void display(){
   imageMode(CENTER);  
   //HEAD
  if(head_pos != null){
    if(player_number == "p1"){
      image(head1, head_pos.x, head_pos.y, 100, 100);
    } else {
      image(head2, head_pos.x, head_pos.y, 100, 100);
    }
  } 
   //TORSO
  if(torso_pos != null){
    if(player_number == "p1"){
      image(tronco1, torso_pos.x, torso_pos.y+50, 100, 250);
    } else {
      image(tronco2, torso_pos.x, torso_pos.y+50, 100, 250);
    }
  } 
   //HANDS
  if(r_hand_pos != null){
    if(player_number == "p1"){
      image(maoD1, r_hand_pos.x, r_hand_pos.y, 35, 35);
    } else {
      image(maoD2, r_hand_pos.x, r_hand_pos.y, 35, 35);
    }
  } 
  if(l_hand_pos != null){
    if(player_number == "p1"){
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
  
}
