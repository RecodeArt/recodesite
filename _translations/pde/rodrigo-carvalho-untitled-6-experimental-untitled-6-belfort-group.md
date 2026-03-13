---
title: "Untitled_6"
translator: "Rodrigo Carvalho"
translator_url: "http://www.visiophone-lab.com/"
slug: "rodrigo-carvalho-untitled-6-experimental-untitled-6-belfort-group"
artwork_slug: "v1n3-untitled-6"
category: "experimental"
description: "Recoding of \"Untitled 6\" by Belfort Group Published originaly in \"Computer Graphics and Art\" 1976 When the code starts it draws the original artwork. When the SPACE is pressed variations of the original are created."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 6" by Belfort Group
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2013 Rodrigo Carvalho - OSI/MIT license (http://recodeproject/license).
*/

//size screen
int w = 600;

//number of col and row
int row = 12;
int col = 16;

//total of cells
int total=col*row;
//keep trackk of the cell number
int totalCount=0;

//rectSize
float rectW=w/16;
float rectH=w/12;

//original artwork sequence
String [] originalSeq={
"b", "b","w","w","w","b","b","w","w","b","b","w",
"b","b","b","b","b","b","b","w","w","b","b","b",
"w","w","b","b","b","b","b","w","w","b","b","b",
"w","w","b","w","b","b","w","b","b","b","b","b",
"b","b","b","w","b","b","w","b","b","b","b","b",
"b","b","b","w","b","b","w","b","w","w","w","b",
"w","b","b","b","b","b","b","b","b","b","b","b",
"w","b","b","b","b","b","b","b","b","b","b","b",
"w","b","b","b","b","w","w","w","w","w","w","b",
"b","b","b","b","w","b","b","w","b","b","b","w",
"b","b","b","b","w","b","b","w","b","b","b","b",
"b","b","b","b","w","b","b","w","w","w","w","b",
"b","w","w","w","w","b","b","b","b","w","b","w",
"b","w","b","b","b","b","b","b","b","w","b","w",
"b","w","b","b","b","b","b","b","b","w","b","w",
"b","b","b","w","b","b","w","b","b","w","b","w",
};

//prob
float ran;

//dinamic probabily. is last one was white, it will improve the next one
float prob=0.25;

boolean generate=false;

void setup(){
 size(w,w);
 background(0); 
noStroke();
  fill(200,10);
  
  // draw original artwork seqeuence
  original ();
}


void draw(){

// the sketch doesn't draw anything unless the space is pressed
if (generate ){
  
 for (int i = 0; i < col; i++) {
  for (int j = 0; j < row; j++) {
 ran=random(1);
   if(ran<prob) 
  { fill(255);
  prob=0.40;
  }
   else { fill(160);
     prob=0.20;
 }  
     rect(j*rectH, i*rectW,rectH, rectW);
  }
}
 }
   generate=false;
 }
 
 
void keyPressed () {

//If space is pressed generate a new sequence  
   if ( key == ' ') {
     generate=!generate;
   }
   
}



void original(){
  
   for (int i = 0; i < col; i++) {
  for (int j = 0; j < row; j++) {

 if(originalSeq[totalCount]=="w")
  { fill(255);
  prob=0.40;
  }
   else { fill(160);
     prob=0.20;
 
 }
     
     rect(j*rectH, i*rectW,rectH, rectW);
    totalCount++;
  }
}
  
}
