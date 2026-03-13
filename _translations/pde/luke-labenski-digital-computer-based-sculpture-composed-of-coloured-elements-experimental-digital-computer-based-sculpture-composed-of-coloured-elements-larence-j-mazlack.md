---
title: "Digital Computer Based Sculpture Composed of Coloured Elements"
translator: "Luke Labenski"
translator_url: "https://github.com/splitty"
slug: "luke-labenski-digital-computer-based-sculpture-composed-of-coloured-elements-experimental-digital-computer-based-sculpture-composed-of-coloured-elements-larence-j-mazlack"
artwork_slug: "v1n2-digital-computer-based-sculpture-composed-of-coloured-elements"
category: "experimental"
description: ""
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Digital Computer Based Sculpture Composed of Coloured Elements" by Larence J Mazlack
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2021 Luke Labenski - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/*
"Digital Computer Based Sculpture Composed of Coloured Elements"
 Larence J Mazlack
 1976
 Computer Graphics
 http://recodeproject.com/artwork/v1n2digital-computer-based-sculpture-composed-of-coloured-elements
 
 Re-Coded by Luke Labenski
 */

//floats used for creating grid
float x = 0;
float y = 0;
//top left grid parameters
int xMax1 = 4;
int yMax1 = 4;
//bottom left grid parameters
int xMax2 = 5;
int yMax2 = 5;
//top right grid parameters
int xMax3 = 5;
int yMax3 = 4;
//bottom right grid parameters
int xMax4 = 5;
int yMax4 = 6;
//square size
float spacing = 45;

//requires JMHTypewriter Think from 
//https://www.dafont.com/jmh-typewriter.font
//font for text
PFont font;


//save frame
int saveF = 0;

//typical setup
void setup() {
  size(500, 500);  
  font = createFont("Typewriter.ttf", 24);
}

//creation of piece
void draw() {
  //white background to match image
  background(255);
  //black stroke to match image
  stroke(0);
  //stroke size to match image
  strokeWeight(5);

  //creating the grids

  //starting x slightly off center
  x = 45;
  //counter to meet grid parameters
  int count = 0;
  //top left grid
  //loop that draws lines
  while (count<xMax1) {
    line(x, 0, x, 210);
    x= x+spacing;
    count++;
  }
  //finishing touches of hand drawn lines
  //right box line
  line(x, 0, x, 210);
  //top box line
  line(0, 2, x, 2);
  //reset count to make grid
  count = 0;
  //same as before
  y = 50;
  while (count<yMax1) {
    line(0, y, x, y);
    y = y+spacing+9;
    count++;
  }
  //bottom left grid
  x=45;
  count = 0;
  while (count<xMax2) {
    line(x, height, x, height-250);
    x=x+spacing;
    count++;
  }
  line(0, height-250, x-spacing, height-250);  
  count=0;
  y=height-1;
  while (count<yMax2) {
    line(0, y, x-spacing, y);
    y = y-50;
    count++;
  }
  //top right grid
  x = width+5;
  count = 0;
  while (count<xMax3) {
    line(x, 0, x, 210);
    x=x-spacing;
    count++;
  }
  line(x, 0, x, 210);
  line(width+2, 2, x, 2);
  count = 0;
  y=50;
  while (count<yMax3) {
    line(width+2, y, x, y);
    y = y+spacing+9;
    count++;
  }
  //bottom right grid
  count = 0;
  x=width+5;
  while (count<xMax4) {
    line(x, height, x, height-250);
    x=x-spacing;
    count++;
  }
  line(x, height, x, height-250); 
  y = height-1;
  count=0;
  while (count<yMax4) {
    line(width, y, x, y);
    y=y-50;
    count++;
  }

  //allow me to more easily draw the black boxes
  rectMode(CENTER);
  //black boxes
  fill(0);

  //top two boxes
  //second box, top
  rect(67, -20, 41, 41);
  //top right secondary
  rect(width-153, -21, 41, 44);
  //fifth box top
  rect(204, 26, 41, 42);
  //top right box
  rect(width-16, 26, 41, 42);
  //top box center
  rect(114, 76, 42, 50);
  //top right box center
  rect(width-108, 76, 43, 52);
  //top left center right box
  rect(158, 131, 40, 48);
  //top right center bottom 
  rect(width-62, 131, 40, 48);
  //top left bottom left
  rect(21, 185, 42, 48);
  //top right bottom left
  rect(width-198, 185, 42, 50);

  //bottom two boxes
  //top left center
  rect(67, 275, 41, 43);
  //top right center
  rect(width-153, 274, 41, 44);
  //top right center left
  rect(204, 324, 41, 45);
  //top right offscreen
  rect(width-16, 324, 41, 45);
  //center dead center
  rect(114, 374, 44, 50);
  //center dead center right box
  rect(width-108, 374, 43, 52);
  //bottom right center left box
  rect(158, 422, 40, 50);
  //right bottom center box
  rect(width-62, 422, 40, 50);
  //bottom left
  rect(21, height-27, 42, 48);
  //bottom right
  rect(width-198, height-27, 42, 48);


  //text for boxes
  textSize(32);
  textFont(font);
  textAlign(CENTER, CENTER);

  //top left box
  //line 1
  text("E", 21, 23);
  text("A", 68, 23);
  text("S", 114, 23);
  text("E", 158, 23);
  //line 2
  text("S", 21, 75);
  text("R", 68, 75);
  text("D", 158, 75);
  text("R", 204, 75);
  //line 3
  text("T", 21, 128);
  text("E", 68, 128);
  text("A", 114, 128);
  text("A", 204, 128);
  //line 4
  text("A", 68, 182);
  text("N", 114, 182);
  text("O", 158, 182);
  text("N", 204, 182);

  //top right box
  //line 1
  text("L", 302, 23);
  text("P", 347, 23);
  //line2
  text("E", 347, 75);
  //line3
  text("A", 347, 128);
  //line4
  text("T", 347, 182);
  text("O", 393, 182);

  //bottom left box
  //line1
  text("A", 114, 271);
  text("R", 158, 271);
  text("T", 204, 271);
  //line2
  text("F", 68, 321);
  //line3
  text("A", 68, 371);
  //line4
  text("W", 68, 421);
  text("A", 114, 421);
  //line5
  text("A", 68, 471);

  //bottom right box
  //line1
  text("A", 393, 271);
  text("R", 438, 271);
  text("T", 483, 271);
  //line2
  text("L", 302, 321);
  text("K", 347, 321);
  //line3
  text("O", 302, 371);
  text("R", 347, 371);
  //line4
  text("I", 347, 421);
  text("P", 393, 421);
  //line5
  text("T", 347, 471);


  //filters for scanned effect
  filter(ERODE);
  filter(DILATE);

  //adding very small dots for detail
  fill(255);
  ellipseMode(CENTER);
  circle(224, 19, 3);
  circle(width-5, 26, 7);
  circle(434, 108, 5);
  circle(204, 319, 5);
  circle(95, 360, 4);
  circle(299, 471, 5);
  //filter to push scanned effect
  //filter(BLUR, 1);
  
  if(saveF == 0){
    saveFrame("SaveFrame.png");
    saveF++;
  }
}
