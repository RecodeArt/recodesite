---
title: "Experiemental Esthetics"
translator: "Jon Bobrow"
translator_url: "http://cargo.jonathanbobrow.com/"
slug: "jon-bobrow-direct-untitled-6-reiner-schneeberger"
artwork_slug: "v3n2-untitled-6-schneeberger"
category: "direct"
description: 'Untitled #5 is part of a 10 piece series, intended to test viewers perception of art and composition. The section is titled "Experimental Esthetics with Computer Graphics -- Analyses of Viewers Impressions of Computer Graphics."'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 6" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" vol3 no2, 1978
Copyright (c) 2012 Jon Bobrow - OSI/MIT license (http://recodeproject/license).
*/

// Untitled #5 is part of a 10 piece series, intended to test viewers
// perception of art and composition. The section is titled "Experimental
// Esthetics with Computer Graphics -- Analyses of Viewers Impressions
// of Computer Graphics."
// note: .f enforces float division, dividing by an int would automatically round down
// i.e. 1/2 = 0 , 1/2.f = .5

let gridSize = 30;
let density = 7;

function setup() {
  createCanvas(480, 720);
  background(255);

  stroke(0);
  strokeWeight(1);
  let padding = gridSize / density;    // even spacing for lines

  let rows = height / gridSize;
  let cols = width / gridSize;

  for (let i = 0; i < rows; i++) {        // iterate over the # of rows (top to bottom)
    for (let j = 0; j < cols; j++) {      // iterate over the # of columns (left to right)

      push();
      translate(j * gridSize, i * gridSize);      // move to grid location
      translate(gridSize / 2, gridSize / 2);  // move to rotate around center

      let prob = map(j / cols, 0, 1, 0.2, 0.8);  // probability between .2 and .8
      if (random(1) < prob) {            // higher probability vertical on the left side
        rotate(3 * PI / 2);                // rotate horizontal
      } else {
        rotate(PI);
      }

      for (let k = 0; k < density; k++) {          // draw # of lines based on density with even spacing
        let _x = (k - density / 2) * padding;
        line(_x, -gridSize / 2, _x, gridSize / 2);
      }
      pop();
    }
  }

  noLoop();
}
</script>
