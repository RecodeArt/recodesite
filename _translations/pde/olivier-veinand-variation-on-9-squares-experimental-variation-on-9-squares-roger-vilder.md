---
title: "Variation on 9 Squares"
translator: "Olivier Veinand"
translator_url: ""
slug: "olivier-veinand-variation-on-9-squares-experimental-variation-on-9-squares-roger-vilder"
artwork_slug: "v1n2-variation-on-9-squares"
category: "experimental"
description: "Based on work from Gerald Kogler I just added randomness in line length You can use key \"a\" to animate"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Variation On 9 Squares" by Roger Vilder
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2020 Olivier Veinand - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Variation on 9 Squares" by Roger Vilder
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Gerald Kogler - OSI/MIT license (http://recodeproject/license).


Based on work from Gerald Kogler
I just added randomness in line length
You can use key "a" to animate

*/

int s = 480;        //size of sketch
int num = 3;        //num of lines and columns in grid
float margin = 30;  //margin around rectangles areas
float overlap = 40; //overlap of reactangle areas
float ease = 0.3;   //easing/division factor for non/linear distribution
char mode = 'e';    //mode 'l'==linear, 'e'==exponential distribution
color bg = 0; 
float r;
Square[] squares = new Square[num*num];

void setup() {
  size(480,480);
  noFill();
  stroke(255);
  r = ((width-2*margin)/num)/2+overlap/num;

  //make instances of squares
  for (int y=0; y<num; y++) {
    for (int x=0; x<num; x++) {
      squares[x+y*num] = new Square(x,y,((x+y*num)%2==0));
    }
  }
dessine();
}

void dessine(){
background(bg);
  for (int i=0; i<num*num; i++) {
    squares[i].draw();
  }
}
int animate=0;

void draw() {
if(animate){  
 dessine();
}
}

void keyPressed() {
  if (key == 'a') {
    animate=!animate;
  } 
  if (key == 's') {
    save("RogerVilder-"+mode+ease+".png");
  }
  else if (key == 'b') {
    if (bg == 0) {
      bg = 255;
      stroke(0);
    }
    else {
      bg = 0;
      stroke(255);
    }
  }
  else if (key == 'm') {
    if (mode == 'l') mode = 'e';
    else mode = 'l';
  }
  else if (key == '+') {
    if (ease > 0.15) ease-=0.1;
  }
  else if (key == '-') {
    if (ease < 1.0) ease+=0.1;
  }
  dessine();
}


void theLine(int x1,int y1,int x2,int y2){
  if(x1==x2){
   for(int y=y1;y<y2;y++){
    stroke(255);
    point(x1,y);
   }
  }else{
   for(int x=x1;x<x2;x++){
    stroke(255);
    point(x,y1);
   }
  }
}

class Square {
  int x,y;       //position in grid
  boolean hor;   //orientation of squares
  
  Square(int x, int y, boolean hor){
    this.x = x;
    this.y = y;
    this.hor = hor;
  }
  
  void draw() {
    float step = 0;
    for (float angle=0; angle<=HALF_PI; angle+=step) {
      if (mode == 'e') step = (HALF_PI+0.1-angle)*ease;
      else step = HALF_PI/(ease*10);
      
      float cx = margin + x*(2*r-overlap);
      float cy = margin + y*(2*r-overlap);
      float sx,sy;      
      if (hor) {
        sx = r +r * cos(angle);
        sy = r+ r * sin(angle);
      }
      else {
        sx = r + r * sin(angle);
        sy = r + r * cos(angle);
      }
      float sw = (r - sx) * 2;
      float sh = (r - sy) * 2;
      line(cx+sx+random(20),cy+sy,cx+sx+sw-random(20),cy+sy);
      line(cx+sx+random(20),cy+sy+sh,cx+sx+sw-random(20),cy+sy+sh);
      line(cx+sx,cy+sy+random(20),cx+sx,cy+sy+sh-random(20));
      line(cx+sx+sw,cy+sy+random(20),cx+sx+sw,cy+sy+sh-random(20));
    }
  }
}
