---
title: "Untitled 2"
translator: "Genevieve Hoffman"
translator_url: "http://www.genevievehoffman.com/portfolio.html"
slug: "genevieve-hoffman-direct-untitled-2-various"
artwork_slug: "v1n4-untitled-2"
category: "direct"
description: "Made by Reiner Shneeberger and students."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Various
Originally published in "Computer Graphics and Art" vol1 no4, 1976
Copyright (c) 2012 Genevieve Hoffman - OSI/MIT license (http://recodeproject/license).
*/

// by Reiner Schneeberger and students
// Computer graphics made at the University of Munich (West Germany)

//1. Size of the sheet of paper.
//2. A scale distortion of 1:2 in one direction.
//3. The routine SNEKAD with eight parameters.
//The routine SNEKAO proves here two elements:
//1. <horizontal lines> 2. <vertical lines>.
//These squares occur in a random order.
//The scale distortion of 1:2 stretches the elements in one direction to produce graying effects.

let cols = 10;
let rows = 80;
let counter = 0;

function setup() {
  createCanvas(540, 800);
  background(255);
  stroke(0);

  let horiz = width / cols;
  let vert = horiz / 2;

  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      let rand = random(0, 2);
      if (rand > 1) {
        //draw vertical lines
        for (let k = 0; k < horiz; k += horiz / 8) {
          line(j * horiz + k, i * vert, j * horiz + k, i * vert + vert);
        }
      }
      else {
        //draw horizontal lines
        for(let k = 0; k < vert; k += vert / 8) {
          line(j * horiz, i * vert + k, j * horiz + horiz, i * vert + k);
        }
      }
    }
  }
}

function draw() {
}

function keyPressed() {
  saveCanvas("Reiner_Schneeberger_Untitled2_####.jpg");
}
</script>
