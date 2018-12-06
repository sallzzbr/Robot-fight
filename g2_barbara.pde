/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

PImage head1, tronco1, maoE1, maoD1;
PImage head2, tronco2, maoE2, maoD2;
PImage hadou1, hadou2;
PImage fundo;
PVector convertedHead, convertedTorso, convertedRHand, convertedLHand;

int fixed_length;

final static ArrayList<Player> players = new ArrayList(); 
//Player[] players;

boolean trigger1 = false;

SimpleOpenNI  context;
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };
PVector com = new PVector();                                   
PVector com2d = new PVector();                                   

void setup()
{
  size(640, 480);
  fundo = loadImage("data/arena.png");
   head1 = loadImage("data/red/cabecaP1.png");
  tronco1 = loadImage("data/red/torsoP1.png");
  maoE1 = loadImage("data/red/mao-esquerdaP1.png");
  maoD1 = loadImage("data/red/mao-direitaP1.png");
  hadou1 = loadImage("data/tiro.png");

  head2 = loadImage("data/blue/cabecaP2.png");
  tronco2 = loadImage("data/blue/torsoP2.png");
  maoE2 = loadImage("data/blue/mao-esquerdaP2.png");
  maoD2 = loadImage("data/blue/mao-direitaP2.png");
  hadou2 = loadImage("data/tiro.png");
  
  context = new SimpleOpenNI(this);
  context.setMirror(true);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // enable depthMap generation 
  context.enableDepth();
   
  // enable skeleton generation for all joints
  context.enableUser();
 
  background(200,0,0);

  stroke(0,0,255);
  strokeWeight(3);
  smooth();  
  //players = new Player[fixed_length];
}

void draw()
{
  // update the cam
  context.update();
  

  imageMode(CORNER);
  image(context.userImage(),0,0);
  
 background(fundo);
 
 for (Player p: players)   p.run();
 if(players.size() == 2){
   for(int i=0;i<2;i++){
     if (players.get(i).full_life == 0){
        gameover(); 
     }
     for(int u=0;u<2;u++){
       if( u == i){
          
        } else {
          players.get(u).collision(players.get(i));
        }
     }
   }
 }
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers(); 
  fixed_length = userList.length;
  if(userList.length >= 2){
    fixed_length = 2;
  }
  for(int i=0;i<fixed_length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
    {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
    }    
      
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      context.convertRealWorldToProjective(com,com2d);
      stroke(100,255,0);
      strokeWeight(1);
      beginShape(LINES);
        vertex(com2d.x,com2d.y - 5);
        vertex(com2d.x,com2d.y + 5);

        vertex(com2d.x - 5,com2d.y);
        vertex(com2d.x + 5,com2d.y);
      endShape();
      
      fill(0,255,100);
      text(Integer.toString(userList[i]),com2d.x,com2d.y);
    }
  }    
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
for(int i=0;i<fixed_length;i++){
//HEAD
 PVector playerHead = new PVector();
 context.getJointPositionSkeleton(i+1, SimpleOpenNI.SKEL_HEAD, playerHead);
 PVector convertedHead = new PVector();
 context.convertRealWorldToProjective(playerHead, convertedHead);
 
 //NECK
// PVector playerNeck = new PVector();
// context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, playerNeck);
// PVector convertedNeck = new PVector();
// context.convertRealWorldToProjective(playerNeck, convertedNeck);
 
 //SHOULDERS
 PVector playerTorso = new PVector();
 context.getJointPositionSkeleton(i+1, SimpleOpenNI.SKEL_TORSO, playerTorso);
 PVector convertedTorso = new PVector();
 context.convertRealWorldToProjective(playerTorso, convertedTorso);
 
 //HANDS
 PVector playerRHand = new PVector();
 context.getJointPositionSkeleton(i+1, SimpleOpenNI.SKEL_RIGHT_HAND, playerRHand);
 PVector convertedRHand = new PVector();
 context.convertRealWorldToProjective(playerRHand, convertedRHand);
 
 PVector playerLHand = new PVector();
 context.getJointPositionSkeleton(i+1, SimpleOpenNI.SKEL_LEFT_HAND, playerLHand);
 PVector convertedLHand = new PVector();
 context.convertRealWorldToProjective(playerLHand, convertedLHand);

  players.get(i).head_pos = convertedHead; 
  players.get(i).torso_pos = convertedTorso; 
  players.get(i).r_hand_pos = convertedRHand; 
  players.get(i). l_hand_pos = convertedLHand; 

}
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  if(userId <= 2){
    curContext.startTrackingSkeleton(userId);
    
    if(userId == 1){
      players.add(new Player("p1", convertedHead, convertedTorso, convertedRHand, convertedLHand));
    }
    if(userId == 2){
      players.add(new Player("p2", convertedHead, convertedTorso, convertedRHand, convertedLHand));
    }
  }
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

void gameover() {
  clear();
  fill(255);
  textSize(48);
  text("GAME OVER", width/2-150, height/2-150);
  textSize(36);
  if (players.get(0).full_life == 0)
    text("PLAYER 1 WINS", width/2-150, height/2-50);
  if (players.get(1).full_life == 0)
    text("PLAYER 2 WINS", width/2-150, height/2-50);
  
  textSize(24);  
  text("Press 'Q' to quit", width/2-150, height/2+150);  

  if (keyPressed) {
    if (key == 'q') {
      exit();
    }
  }
}


void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }
}  

