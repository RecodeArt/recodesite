---
title: "Untitled 1"
translator: "Martin Schneider"
translator_url: ""
slug: "martin-schneider-direct-untitled-1-vladimir-bonacic"
artwork_slug: "v2n3-untitled-1"
category: "direct"
description: "Click the canvas, then any key to redraw."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Vladimir Bonacic
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Martin Schneider - OSI/MIT license (http://recodeproject/license).
*/

////////////////////////////////////////////////////////////////////////
//                                                                    //
//           "Orbits of Galois Fields" by Vladimir Bonačić            //
//                                                                    //
//                          ( untitled 1)                             //
//                                                                    //
////////////////////////////////////////////////////////////////////////

// These patterns are displayed using 32 x 32 dots.
// They visualize objects from  abstract algebra,
// namely orbits of galois fields.

// Source:
// "Research and Teaching in Art and Science" by Vladimir Bonačić
// Computer Graphics and Art Vol. 2, No. 3 pp. 4-8

// See also:
// "Kinetic Art: Application of Abstract Algebra to Objects with Computer-
// Controlled Flashing Lights and Sound Combinations" by Vladimir Bonačić
// Leonardo, Vol. 7, No. 3
// Note: This paper is quite mathematical at times.
// The implementation however is actually really simple.


/////////////////////////////// UNTITLED 1  ////////////////////////////

// This is a recreation of the four orbits shown in the right column

// Fig e) and f)  generator polynomial: x^10 + x^7 + x^2 + 1
// Fig g) and h)  generator polynomial: x^10 + x^5 +x^4 +x^3 + x^2 + x^1 + 1

// NOTE:
// The images in the original publication are flipped in various ways.
// This may be due to different axis directions, indexing order,
// an error in  reproduction, or a combination of all of the above.


////////////////////////////////////////////////////////////////////////

let n = 5;           // bits per dimension
let d = 1 << n;      // cells per dimension
let led = 10;        // size of the dot
let w = led * d + 1; // screen size

let preset = [1087, 1087, 1157, 1157];
let offset = [2, 31, 9, 15];
let pick = 0;


function setup() {
  createCanvas(w, w);
  ellipseMode(CORNER);
  stroke(255);
  fill(0);
}


function draw() {
  let p = preset[pick];
  let i = offset[pick];

  // create empty field
  let field = new Array(d * d).fill(false);

  // find all cells in the orbit
  while (!field[i]) {
    field[i] = true;
    i *= 2;
    if (i >= d * d) i ^= p;
  }

  // draw display
  background(255);
  for (i = 0; i < d * d; i++) {
    if (field[i]) {
      ellipse(led * (i % d), led * floor(i / d), led, led);
    }
  }
}


function keyPressed() {
  pick = (pick + 1) % preset.length;
}
</script>
