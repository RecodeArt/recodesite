---
title: "Dynamic Object"
translator: "Martin Schneider"
translator_url: ""
slug: "martin-schneider-experimental-untitled-2-vladimir-bonacic"
artwork_slug: "v2n3-untitled-2"
category: "experimental"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 2" by Vladimir Bonacic
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Martin Schneider - OSI/MIT license (http://recodeproject/license).
*/

////////////////////////////////////////////////////////////////////////
//                                                                    //
//   "Dynamic Object GF.E (16, 4) 69/71" by Vladimir Bonačić          //
//                                                                    //
//                     (interactive version)                          //
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


///////////////////////// INTERACTIVE VERSION ///////////////////////////

// This is the dynamic interactive version with pattern cycling and
// mouse interaction ( the original had 32 keys to control the pattern )

// - press space to toggle animation
// - press 'p' to switch through presets
// - press 'g' to toggle afterglow
// - use the mouse to modify the pattern


////////////////////////////////////////////////////////////////////////

let d = 1 << 5;          // cells per dimension
let led = 10;            // size of the light bulb
let w = led * d + 1;     // display size
let pick = 1;            // picked preset

// we need proper handling for 32 bit positive integers
let preset = [4294967295, 100675584, 2146959392, 4293918847];

// there are 2^32 different patterns controlled by the 32 bits of p
let p = preset[pick];

// the generator is used to create a more interesting pattern sequence
let generator = 4299161607;

let frames = 60;
let animate = true;
let debug = true;
let glow = true;

function setup() {
  createCanvas(w, w);
  frameRate(60);
  info();
}


function draw() {
  // add some afterglow
  fill(0, glow ? 30 : 255);
  rect(0, 0, w, w);
  fill(255);

  // draw the pattern
  for (let y = 0; y < d; y++) {
    for (let x = 0; x < d; x++) {
      // this is where the magic happens
      if ((1 << (x ^ y) & p) > 0) {
        rect(led * x, led * y, led, led);
      }
    }
  }

  // jump to a different pattern
  if (animate && frameCount % frames == 0) {
    p *= 2;
    if (p >= 1 << d) p ^= generator;
    info();
  }

  // change the pattern using the mouse
  if (mouseIsPressed) {
    let x = floor(mouseX / led) & (d - 1);
    let y = floor(mouseY / led) & (d - 1);
    let bit = 1 << (x ^ y);
    p = mouseButton === LEFT ? p | bit : p & ~bit;
    info();
  }
}


function keyPressed() {
  switch (key) {
    // animation on/off
    case ' ':
      animate = !animate;
      return;
    // switch between presets
    case 'p':
      p = preset[pick = (pick + 1) % preset.length];
      animate = false;
      break;
    // next pattern
    case '+':
      p++;
      break;
    // previous pattern
    case '-':
      p--;
      break;
    // toggle afterglow
    case 'g':
      glow = !glow;
      break;
    // toggle debugging
    case 'd':
      debug = !debug;
    default:
      return;
  }

  // constrain to 32 bits
  p &= ((1 << d) - 1);
  info();
}


// show pattern input
function info() {
  if (debug) console.log("p = [" + p.toString(2).padStart(d, '0') + "] = " + p);
}
</script>
