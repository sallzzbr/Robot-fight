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
  hadou1 = loadImage("data/hadouken.png");

  head2 = loadImage("data/blue/cabecaP2.png");
  tronco2 = loadImage("data/blue/torsoP2.png");
  maoE2 = loadImage("data/blue/mao-esquerdaP2.png");
  maoD2 = loadImage("data/blue/mao-direitaP2.png");
  hadou2 = loadImage("data/hadouken2.png");
  
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
}

void draw()
{
 //background(fundo);
  // update the cam
  context.update();
  
  // draw depthImageMap
  //image(context.depthImage(),0,0);
  imageMode(CORNER);
  image(context.userImage(),0,0);
  
 background(fundo); 
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers(); 
  int teste = userList.length;
  if(userList.length >= 2){
    teste = 2;
  }
  for(int i=0;i<teste;i++)
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
  
//  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);

//HEAD
 PVector playerHead = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, playerHead);
 PVector convertedHead = new PVector();
 context.convertRealWorldToProjective(playerHead, convertedHead);
 
 //NECK
// PVector playerNeck = new PVector();
// context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, playerNeck);
// PVector convertedNeck = new PVector();
// context.convertRealWorldToProjective(playerNeck, convertedNeck);
 
 //SHOULDERS
 PVector playerRshoulder = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, playerRshoulder);
 PVector convertedRshoulder = new PVector();
 context.convertRealWorldToProjective(playerRshoulder, convertedRshoulder);
 
 PVector playerLshoulder = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, playerLshoulder);
 PVector convertedLshoulder = new PVector();
 context.convertRealWorldToProjective(playerLshoulder, convertedLshoulder);
 
 //HIP
 PVector playerRhip = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, playerRhip);
 PVector convertedRhip = new PVector();
 context.convertRealWorldToProjective(playerRhip, convertedRhip);
 
 PVector playerLhip = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, playerLhip);
 PVector convertedLhip = new PVector();
 context.convertRealWorldToProjective(playerLhip, convertedLhip);
 
 //HANDS
 PVector playerRHand = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, playerRHand);
 PVector convertedRHand = new PVector();
 context.convertRealWorldToProjective(playerRHand, convertedRHand);
 
 PVector playerLHand = new PVector();
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, playerLHand);
 PVector convertedLHand = new PVector();
 context.convertRealWorldToProjective(playerLHand, convertedLHand);
 
 
 imageMode(CENTER);
 //HEAD
 image(head1, convertedHead.x, convertedHead.y, 100, 100);
 //TORSO
 image(tronco1, (convertedRhip.x + convertedLhip.x)/2, (convertedRshoulder.y + convertedRhip.y)/1.75, 100, 250);
 //HANDS
 image(maoD1, convertedRHand.x, convertedRHand.y, 35, 35);
 image(maoE1, convertedLHand.x, convertedLHand.y, 35, 35);
 
// println("1", (convertedRhip.x + convertedLhip.x)/2);
// println("2", (convertedRshoulder.y + convertedRhip.y)/2);
// println("3", (convertedRhip.x - convertedLhip.x));
// println("4", (convertedRhip.y - convertedRshoulder.y));

}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
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

