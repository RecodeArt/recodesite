---
title: "Untitled 3"
translator: "Martin Schneider"
translator_url: ""
slug: "martin-schneider-direct-untitled-3-vladimir-bonacic"
artwork_slug: "v2n3-untitled-3"
category: "direct"
description: ""
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Vladimir Bonacic
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Martin Schneider - OSI/MIT license (http://recodeproject/license).
*/

////////////////////////////////////////////////////////////////////////
//                                                                    //
//   "Dynamic Object GF.E (16, 4) 69/71" by Vladimir Bonačić          //
//                                                                    //
//                     ( untitled 3 )                                 //
//                                                                    //
////////////////////////////////////////////////////////////////////////

// The dynamic object is a 32 x 32 display.
// It visualizes objects from  abstract algebra, 
// which are known as Galois groups.

// Source:
// "Research and Teaching in Art and Science" by Vladimir Bonačić
// Computer Graphics and Art Vol. 2, No. 3 pp. 4-8

// See also:
// "Kinetic Art: Application of Abstract Algebra to Objects with Computer-
// Controlled Flashing Lights and Sound Combinations" by Vladimir Bonačić
// Leonardo, Vol. 7, No. 3
// Note: This paper is quite mathematical at times.
// The implementation however is actually really simple.


///////////////////////////// UNTITLED 2 ///////////////////////////////

// this sketch simply creates the 4 patterns of the 3rd image 
// in the article from the pattern presets given below. 

// Press any key to switch between patterns

long[] preset = { 196632,  25362456l , 143654784, 4278196223l  };

int d = 1<<5;            // cells per dimension
int led = 10;            // size of the light bulb
int w = led * d + 1;     // display size
int p = 0;

void setup() {
 size(w, w);
}

void draw() {
  background(0);  
  for(int y = 0; y < d; y++) {
    for(int x = 0; x < d; x++) {
      if( (1l<<(x^y) & preset[p] ) > 0) {
        rect(led * x, led * y, led, led);
      }
    }
  }
}

void keyPressed() {
  p = (p + 1) % preset.length;
}
