---
title: "Square Spiral"
translator: "Yuri Popov"
translator_url: ""
slug: "yuri-popov-square-spiral-experimental-untitled-3-hans-korneder"
artwork_slug: "v3n2-untitled-3-Korneder"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Hans Korneder
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2014 Yuri Popov - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

float angle = 5, _size = 200, step = 2;
int steps = 100, len = 1;
float[] angs = new float[steps];

void setup()
{  
  size(800, 400, P2D);
  rectMode(CENTER);

  smooth(8);
  
  angs[0]=0;
  
  for ( int i = 1; i < steps; i++ )   
    angs[i] = angs[i-1]+TWO_PI/steps;   
}

void draw() 
{
  background(0);
  translate( width*0.5, height*0.5 );

  for ( int i = 0; i < len; i++ ) 
  {    
    fill(204/steps*i, 12/steps*i, 100/steps*i);
    
    pushMatrix();
    rotate(angs[i]);
    float side = _size - (step * i);
    rect( 0, 0, side, side);
    popMatrix();
  }
if(frameCount % 2 == 0) len++;
  if (len==angs.length) len =1; 
}
