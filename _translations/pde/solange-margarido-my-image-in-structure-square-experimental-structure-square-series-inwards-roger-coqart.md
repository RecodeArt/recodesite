---
title: "My Image in Structure Square"
translator: "Solange Margarido"
translator_url: ""
slug: "solange-margarido-my-image-in-structure-square-experimental-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "experimental"
description: "Transform an image to Structure Square look. Derived from Kyle McDonald's translation of Roger Coqart's \"Structure Square Series Inwards\"."
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure Square Series Inwards" by Roger Coqart
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2021 Solange Margarido - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int side = 24; //change this value to determine the size of the squares
int lines = 8;
int n = lines * 2 + 1;
int margin = side / 2;
int offset = side + margin;
int canvas = (n + 1) * offset;
boolean[] enabled = new boolean[lines];

// If detail is smaller than the side it allows us to map less pixels of the image to more squares
int detail = (int)(side/1.8);

PImage img;

String img_name;

int size;

void settings(){
  img_name = "apple.jpg"; //path of the image you want to transform
  img = loadImage(img_name);
  
  int x_size = img.width / detail;
  int y_size = img.height / detail;
  
  size((x_size * side) + (x_size * margin) + margin * 3, (y_size * side) + (y_size * margin) + margin * 3);
}

void setup() { 
  noLoop();

  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(360, 0, 100);
  translate(side, side);

  int x_size = img.width / detail;
  int y_size = img.height / detail;
  println(x_size);
  println(y_size);

  img.loadPixels();
  for (int y = 0; y < y_size; y++) {
    for (int x = 0; x < x_size; x++) {
      // average of a group of pixels
      float total_brightness = 0;
      for (int i = 0; i < detail; ++i) {
        for (int j = 0; j < detail; ++j) {
          int idx = ((y * detail) + i) * img.width + ((x * detail) + j);
          total_brightness += brightness(img.pixels[idx]);
        }
      }

      float average_brightness = total_brightness / (detail*detail);

      // enable some lines
      int total = (int) ((1 - (average_brightness / 100)) * lines);
      for (int i = 0; i < lines; i++) {
        enabled[i] = i < total;
      }

      // shuffle the enabled lines
      for (int i = 0; i < lines; i++) {
        boolean swap = enabled[i];
        int j = (int) random(lines);
        enabled[i] = enabled[j];
        enabled[j] = swap;
      }

      // draw all enabled lines
      pushMatrix();
      strokeWeight(2);
      translate(x * offset, y * offset);
      rect(0, 0, side, side);
      strokeWeight(3);
      if (enabled[0]) line(0, side / 2, side, side / 2);
      if (enabled[1]) line(side / 2, 0, side / 2, side);
      if (enabled[2]) line(0, 0, side, side);
      if (enabled[3]) line(0, side, side, 0);
      if (enabled[4]) line(0, side / 2, side / 2, 0);
      if (enabled[5]) line(side / 2, 0, side, side / 2);
      if (enabled[6]) line(side, side / 2, side / 2, side);
      if (enabled[7]) line(side / 2, side, 0, side / 2);
      popMatrix();
    }
  }

  save(img_name); //the new image will be saved in your project folder
}
