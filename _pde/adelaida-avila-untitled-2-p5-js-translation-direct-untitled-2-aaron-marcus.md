---
title: "Untitled 2"
translator: "Adelaida Avila"
translator_url: ""
slug: "adelaida-avila-untitled-2-p5-js-translation-direct-untitled-2-aaron-marcus"
artwork_slug: "v3n2-untitled-2-marcus"
category: "direct"
description: "Composition done in P5.js recreating Untitled 2 composition made by Aaron Marcus in 1978."
runs_in_browser: true
---

<script type="text/processing">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 2" by Aaron Marcus
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2022 Adelaida Avila - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

//Composition recreating "Untitled 2", from the Hieroglyph series  by Aaron Marcus, 1978.
//Retrieved from the ReCode project: http://recodeproject.com/artworks/v3n2untitled-2-marcus
//made by Adelaida Avila Cabrera, March 2022.
  let numElements = 6;

function setup() {
  //set canvas size
  createCanvas(800, 800);
  //define style elements
  noFill();
  strokeWeight(2);
  //change angles from radians to degrees
  angleMode(DEGREES);
}

function draw() {
  //define style elements
  background(0);
  stroke(255);

  //grid variables
  let cellWidth = width / numElements;
  let cellHeight = height / numElements;

  //grid loop
  for (let row = 0; row < numElements; row++) {
    for (let col = 0; col < numElements; col++) {
      let x = col * cellWidth;
      let y = row * cellHeight;
      //grid rectangles
      rect(x, y, cellWidth, cellHeight);
      let x1 = random(x, x + cellWidth);
      let y1 = random(y, y + cellHeight);
      let x2 = random(x, x + cellWidth);
      let y2 = random(y, y + cellHeight);
      let x3 = random(x, x + cellWidth);
      let y3 = random(y, y + cellHeight);
      let x4 = random(x, x + cellWidth);
      let y4 = random(y, y + cellHeight);
      //lines inside grid
      line(x1, y1, x2, y2);
      //circles inside grid
      circle(x2, y3, random(1, cellWidth));
      push();
      //randomly rotate squares
      rotate(random(360));
      //squares inside grid
      rect(x4, y4, random(1, cellWidth / 2));
      pop();
    }
  }
  noLoop();
}


//click to redraw shapes in another random order
function mousePressed() {
  redraw();
}
</script>
