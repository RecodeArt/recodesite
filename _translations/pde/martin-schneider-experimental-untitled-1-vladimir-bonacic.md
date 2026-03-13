---
title: "Galois Orbits"
translator: "Martin Schneider"
translator_url: ""
slug: "martin-schneider-experimental-untitled-1-vladimir-bonacic"
artwork_slug: "v2n3-untitled-1"
category: "experimental"
description: "Move mouse over the canvas to redraw."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Galois Orbits" by Vladimir Bonacic
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Martin Schneider - OSI/MIT license (http://recodeproject/license).
*/

////////////////////////////////////////////////////////////////////////
//                                                                    //
//           "Orbits of Galois Fields" by Vladimir Bonačić            //
//                                                                    //
//                       ( interactive version )                      //
//                                                                    //
////////////////////////////////////////////////////////////////////////

// These patterns are displayed using 32 x 32 dots.
// They visualize objects from  abstract algebra, 
// which are known as orbits of galois fields.

// Source:
// "Research and Teaching in Art and Science" by Vladimir Bonačić
// Computer Graphics and Art Vol. 2, No. 3 pp. 4-8

// See also:
// "Kinetic Art: Application of Abstract Algebra to Objects with Computer-
// Controlled Flashing Lights and Sound Combinations" by Vladimir Bonačić
// Leonardo, Vol. 7, No. 3
// Note: This paper is quite mathematical at times.
// The implementation however is actually really simple.


///////////////////////// INTERACTIVE VERSION  /////////////////////////

// - Use space to flip through the presets
// - Use '+' and '-' to generate a different galois field
// - Use 'b' to toggle background color
// - Use the mouse to explore the orbits


////////////////////////////////////////////////////////////////////////

int n = 5;           // bits per dimension
int d = 1<<n;        // cells per dimension
int led = 10;        // size of the dot
int w = led * d + 1; // screen size

int[] preset = {1087, 1157};
int pick = 0;
int p = preset[pick];

boolean debug = true;
int i0, bg;


void setup() {
  size(w, w);
  ellipseMode(CORNER); 
  noStroke();
}


void draw() {
  
  // adding some afterglow
  fill(bg, 30); rect(0, 0, w, w); fill(255 - bg);

  // use mouse coordinates to get initial cell
  int x = mouseX/led & (d-1);
  int y = mouseY/led & (d-1);
  int i = y * d + x;

  // create empty field
  boolean[] field = new boolean[d*d];

  // find all cells in the orbit
  i0 = d*d;
  while (!field[i]) {
    i0 = min(i, i0);
    field[i] = true;
    i *= 2; 
    if (i >= d*d )  i ^= p;
  } 

  // draw display
  for (i = 0; i < d*d; i++) {
    if (field[i]) {
      ellipse(led * (i % d), led * floor(i / d), led, led);
    }
  }
}


void keyPressed() {
  switch(key) {
    // switch between presets
    case ' ':  pick = (pick + 1) % preset.length;  p = preset[pick];  break;
    // next pattern
    case '+': p = (p + 1) | d; break; 
    // previous pattern
    case '-': p = (p - 1) | d; break;
    // toggle debugging
    case 'd': debug = !debug; break;
    // switch background color
    case 'b': bg = 255 - bg; break;
    default: return;
  }
}


void mouseClicked() {
  info();
}


// show generator polynomial + orbit entry point
void info() {
  if (debug) println("p = [" + binary((int) + p, d)+  "] = " + p + "; i0 = " + i0);
}
