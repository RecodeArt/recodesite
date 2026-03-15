---
title: "Hex Variations"
translator: "Steve Berrick"
translator_url: "http://about.me/steve.berrick"
slug: "steve-berrick-direct-hex-variation-william-kolmyjec"
artwork_slug: "v3n4-hex-variation"
category: "direct"
description: "Move the mouse inside the canvas to redraw."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Hex Variation" by William Kolomyjec
Originally published in "Computer Graphics and Art" vol3 no4, 1978
Copyright (c) 2012 Steve Berrick - OSI/MIT license (http://recodeproject/license).
*/

let _width = 600;
let _height = 900;
let _size = 20; // Hexagon radius

function setup() {
  createCanvas(_width, _height);
  noLoop();

  background(255);
  noFill();
  stroke(0);
  strokeWeight(2);
}

function draw() {
  // Clear background
  background(255);

  // Line length (hypotenuse)
  let h = sin(PI / 3) * _size;

  for (let i = 0; i <= _width / (_size * 3); i++) {
    for (let j = 0; j <= (_height / h) + 1; j++) {
      // Reference points (centre of each hexagon)
      let x = i * _size * 3 + (_size / 2);
      let y = j * h;

      // Offset each odd row
      if (j % 2 > 0) {
        x += _size * 1.5;
      }

      push();
      translate(x, y);

      // Random hexagon rotation (0, 120, 240 degrees)
      rotate(Math.floor(random(0, 3)) * PI / 3);

      // Draw line
      line(0, -h, 0, h);

      // Draw arcs
      arc(-_size, 0, _size, _size, -PI / 3, PI / 3);
      arc(_size, 0, _size, _size, PI / 3 * 2, PI / 3 * 4);

      pop();
    }
  }
}

function mousePressed() {
  redraw();
}
</script>
