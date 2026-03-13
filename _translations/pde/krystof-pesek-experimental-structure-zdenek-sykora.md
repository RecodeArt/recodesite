---
title: "Structure"
translator: "Krystof Pesek"
translator_url: "http://kof.shellmix.com/"
slug: "krystof-pesek-experimental-structure-zdenek-sykora"
artwork_slug: "v1n2-structure"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure" by Zdenek Sykora
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Krystof Pesek - OSI/MIT license (http://recodeproject/license).
*/

/////////////////////////////////

float theta[];
PGraphics plny;
int [] moznosti = {0,90,180,270};
float [] rot = {1,2,4};
float  r;

/////////////////////////////////

void setup(){
  size(576,704,P2D);
  imageMode(CENTER);

  plny = createGraphics(32,32,JAVA2D);
  createShaped();

  theta = new float[3000];
  for (int i = 0 ; i < theta.length ; i ++){
    theta[i] = moznosti[(int)random(4)];
  }
}

/////////////////////////////////

void draw(){
  background(0);

  r = plny.width;

  int idx = 0;
  for(int y = 0;y <= height/plny.height;y++){
    for(int x = 0;x <= width/plny.width;x++){
      pushMatrix();
      translate(x*r+plny.width/2,y*r+plny.height/2);
      rotate(radians(theta[idx]));
      theta[idx] += 0.004*degrees(frameCount/200.0*atan2(mouseY-y*r,mouseX-x*r));
      image (plny,0,0);
      popMatrix();

      idx += 1;
    }
  }
}

/////////////////////////////////

void createShaped(){
  int W = plny.width;
  int H = plny.height;

  plny.beginDraw();
  plny.smooth();
  plny.fill(255);
  plny.noStroke();
  plny.arc(W/2,H/2,W-2,H-2,0,PI);
  plny.endDraw();
}

/////////////////////////////////
