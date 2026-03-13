---
title: "Plasma"
translator: "Yuri Popov"
translator_url: ""
slug: "yuri-popov-plasma-experimental-untitled-graphic-also-giorgini"
artwork_slug: "v2n2-untitled-graphic-also%20girogini"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled Graphic" by Also Giorgini
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2014 Yuri Popov - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

float step =400;
int pal []=new int [128];
int[] cls;
 
void setup()
{
  size(800, 400);
  smooth(8);
  
  float s1,s2;    
  int shift = 254;

  for (int i=0; i<128; i++)
  {
    s1=sin(i*PI/25);
    s2=sin(i*PI/50+PI/4);
    pal[i]=color(s1*shift,s2*shift,200+s1*shift);
  }
 
  cls = new int[width*height]; 
  float period = 92.0;
  
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      float a = step + step * sin(x / period);
      float b = step + step * cos(y / period);
      float c = step + step * sin(sqrt(x * x + y * y) / period);
      cls[x+y*width] = (int)(a + b + c) / 4;
    }
  }
}
 
void draw()
{
  loadPixels();
  for (int pixelCount = 0; pixelCount < cls.length; pixelCount++)
  {                   
    pixels[pixelCount] = pal[(cls[pixelCount] + frameCount)&27];
  }
  updatePixels(); 
}
