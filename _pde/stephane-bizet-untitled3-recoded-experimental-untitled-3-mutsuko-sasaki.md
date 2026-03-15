---
title: "Untitled3_Recoded"
translator: "Stéphane Bizet"
translator_url: ""
slug: "stephane-bizet-untitled3-recoded-experimental-untitled-3-mutsuko-sasaki"
artwork_slug: "v3n3-untitled-3-sasaki"
category: "experimental"
description: "The two function called f(t) and g(t) in the magazine are unknown. I tried a few functions with different parameters. Two parameters can be changed with mouseX and mouseY."
runs_in_browser: true
---

<script type="text/processing">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Mutsuko K. Sasaki
Originally published in "Computer Graphics and Art" v3n3, 1978
Copyright (c) 2013 Stéphane Bizet - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

// For the Recode Project
// Stéphane Bizet 5/10/2013

float radius;
int xc;
int yc;
int nCircle=9;

float x, y;

void setup(){
  size(800,600);
  stroke(20, 50, 70);
  strokeWeight(5);
  xc=width/2;
  yc=height/2;
}


void draw(){
  background(255);
  for(int i=0;i<nCircle;i++){
    radius = (i+1)*20;                      // the radius starts on 20 and gets bigger for each loop
    for (float ang=0;ang<=360;ang+=0.2){    // a full rotation
      float rad=ang*PI/180;                 //transform ang in radians rather than degrees
      float radiusTransformX = 3*radius/2+radius*(radius/(mouseY*1000.0/height))*cos(2*rad-5.0*mouseX/width);   //changes the radius depending on the angle and the size of the circle
      float radiusTransformY = radius+(radius/2)*(1-radius/200);
      x = xc + (radiusTransformX * cos(rad));
      y = yc + (radiusTransformY * sin(rad));
      point(x,y);
    }
  }
}
</script>
