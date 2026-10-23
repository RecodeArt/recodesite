---
title: "Boxes"
translator: "Sermad Buni"
translator_url: "http://www.sermad.com/"
slug: "sermad-buni-direct-boxes-i-william-kolomyjec"
artwork_slug: "v2n3-boxes-i"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Boxes I" by William Kolomyjec
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Sermad Buni - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  let canvaswidth = 17;
  let canvasheight = 10;
  let square_size = 40;
  let randomness = 0.03;

  // Set the size of the canvas
  createCanvas((canvaswidth + 2) * square_size, (canvasheight + 2) * square_size);

  // Set the background of the canvas
  background('#ffffff');

  // Draw the squares
  // By default squares are drawn with a filled colour so we need to turn this off
  noFill();

  // We need to make a loop in a loop
  for (let i = 0; i < canvaswidth; i++) {
    for (let j = 0; j < canvasheight; j++) {
      push();

      // Move the origin to the pivot point
      translate(square_size * i, square_size * j);

      // Simple algo to increase rotation towards the middle of the grid
      // Check for odd or even canvas size to slightly alter the algo
      let iw, jh;

      if (canvasheight % 2 === 0) {
        iw = canvaswidth / 2 - Math.abs(i - canvaswidth / 2);
      } else {
        iw = canvaswidth / 2 - 0.5 - Math.abs(i - canvaswidth / 2 - 0.5);
      }

      if (canvasheight % 2 === 0) {
        jh = canvasheight / 2 - 0.5 - Math.abs(j - canvasheight / 2 + 0.5);
      } else {
        jh = canvasheight / 2 - Math.abs(j - canvasheight / 2);
      }

      // Check if we are not drawing the outer edges
      if (jh !== 0 || iw !== 0) {
        // Rotate the square
        rotate(radians(iw * iw * jh * jh * random(-randomness, randomness)));
      }

      // Draw the square at the origin
      rect(square_size, square_size, square_size, square_size);

      pop();
    }
  }
}
</script>
