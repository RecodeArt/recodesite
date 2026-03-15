---
title: "Density Variant"
translator: "Clay Shirky"
translator_url: ""
slug: "clay-shirky-density-variant-experimental-untitled-georg-nees"
artwork_slug: "v1n2-untitled18"
category: "experimental"
description: "I am interested in the smallest changes that can be made to a sketch that leave the original gesture recognizable, but generate visibly different output. In this case, I took Allick's re-coding of Nees' work and varied only one thing -- the minimum and maximum number of lines to be drawn. This affects the script on only one line: for( int i = 0; i This is the code that counts off the number of lines to be be drawn in each circle. Allick has min set to 100 and max to 300, producing a density that mirrors Nees's. I altered the instructions to produce between 1 (min = 1) and 10,000 (max = 10000) lines. The result preserves the large composition -- four circles visible as the cumulative end points of straight lines -- but makes the variation between the circles quite different. At the low end, there are so few lines you can lose track of a circle, and at the high end, you can lose track of the individual lines. This outcome is less graphically balanced (and less interesting to look at) than the original, but demonstrates how much flexibility there is, within a working sketch, for minor alteration of the defaults."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Georg Nees
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Clay Shirky - OSI/MIT license (http://recodeproject/license).
*/

let radius = 150;
let min, max;

function setup() {
  createCanvas(600, 600);
  background(255);
  stroke(0);
  noFill();
  strokeWeight(2);
  min = 1;
  max = 10000;
  drawCircles();
}

function draw() {}

function drawCircles() {
 background(255);

 for(let r = 0; r < 2; r++) {
   for(let c = 0; c < 2; c++) {
      push();
        translate(150 + (300 * r), 150 + (300 * c));
        //ellipse(0, 0, 300, 300);
        for(let i = 0; i < int(random(min, max)); i++) {
          let a = random(0, TWO_PI);
          let x1 = radius * cos(a);
          let y1 = radius * sin(a);
          a = random(0, TWO_PI);
          let x2 = radius * cos(a);
          let y2 = radius * sin(a);

          line(x1, y1, x2, y2);
        }
      pop();
   }
 }
}

function mousePressed() {
  drawCircles();
}
</script>
