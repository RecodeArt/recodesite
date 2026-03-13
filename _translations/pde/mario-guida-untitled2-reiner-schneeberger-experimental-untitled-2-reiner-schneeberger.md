---
title: "Untitled2_Reiner_Schneeberger"
translator: "Mario Guida"
translator_url: "http://www.marioguida.org/"
slug: "mario-guida-untitled2-reiner-schneeberger-experimental-untitled-2-reiner-schneeberger"
artwork_slug: "v3n2-untitled-2-schneeberger"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 2" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Mario Guida - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int W = 500;
int H = 500;
float dh0,dh1,dw0,dw1;
float block,ds;
float exp;
float mul_factor;
int sample_rate;
int block_space;

LineGroup obj;

void setup()
{
  size(500,500);
  block_space = 9;
  block = H/block_space; //9
  ds = block/2;
  exp = 12;
  mul_factor = 1;
  sample_rate = 4;
  
  obj = new LineGroup();
  
  noLoop();
}

void draw()
{
  background(255);

  int counter = 1;
  
  dw0 = 0;
  dw1 = W;
  dh0 = 0;
  dh1 = 0;   
  
  for (float a = 0; a <= PI; a = a+(PI/sample_rate) )
  {    
    float div = abs(cos(a)) + (exp-abs(cos(a)));
    dh0 = dh1;
    dh1 = dh0 + (mul_factor*block);
    obj.Settings(dh0, dh1, dw0, dw1, block/div, 0);
    
    if(counter<=sample_rate/2)
    {
      exp = exp/2;
      mul_factor++;
    }
    else
    {
      exp = exp*2;
      mul_factor--;
    }    
    counter ++;
  }   
  
  dw0 = 0;
  dw1 = 0;
  float delta_s=0;
  float space = 0;
  for (int i=0; i<sample_rate; i++)
  {
    dh0 = (sample_rate-i)*block;
    dh1 = dh0 + ( ( (2*i) + 1) * block) ;
    dw0 = dw1;
    
    if (i==0) 
    { 
      dw1 = dw0 + ( (13*W) / 100); 
      delta_s = dw1-dw0; 
      space = delta_s/28;
    }
    else 
    { 
      dw1 = dw0 + ( (29*W) / 100);
      delta_s = dw1-dw0;  
      space =  delta_s/(60-(16*i ));
    }    
    obj.Settings(dh0, dh1, dw0, dw1, space, 1);
  }  
}




class LineGroup
{
  int c;
  float x,y,dx,dy;
  float nline;
  float space;
  int type; // 0 = orizontal and  1 = vertical
  
  LineGroup()
  {
    c = 0;
    space = 1;
    x = 0;
    y = 0;
    dx = 0;
    dy = 0;
    type = 0;    
  }
    
  
  void Settings(float dh0, float dh1, float dw0, float dw1, float div, int t)
  {
    x = dw0;
    y = dh0;
    dx = dw1;
    dy = dh1;
    nline = div;
    type = t;
    space = div;
    Display();
  }
  
  void Display()
  {
    //strokeWeight(2);
    if (type == 0) 
    {
      for(float i=y; i<dy-1; i = i + space)
      {
        line(x,i,dx,i);       
      }
    }
    else
    {
      for(float i=x; i<dx-1; i = i + space)
      {
        line(i,y,i,dy);       
      }
    }   
    
  }
 
}
