---
title: "Translation Tuner"
translator: "Clay Shirky"
translator_url: ""
slug: "clay-shirky-translation-tuner-experimental-aeleana-manuel-barbadillo"
artwork_slug: "v1n2-aeleana"
category: "experimental"
description: "Reading Makio135's code, I noticed that the number 25 had been used many times to tune the output, appearing in the increasingly complex instructions for drawing various rectangles. The relevant lines are: pg.rect(-125, -100, Size+25, Size, 25, 25); pg.rect(-125, -100, Size, Size-25, 25, 25); pg.rect(-125, -125, Size/2+25, 175-i*25, 25, 25); pg.rect(0, -Size/2+i*25, Size/2-i*25, (i==0)?Size/2:Size-(2*i)*25, (Size/2-i*25>25)?25:15, (Size/2-i*25>25)?25:15); I changed all those 25s to a variable, which I called 'tune' on the sense that this number tuned the drawing to the output Makio135 wanted. I added a second variable, called 'tuneStep', which adjusts increases to 'tune', and then I tied that math to mouse clicks: void mousePressed() { tune += tuneStep; } I set both tune and tuneStep to 5, which means that, after 4 clicks, you get Makio135's homage to Barbadillo's original image, but values of tune other than 25 make strikingly different layouts. (The screenshot is 'tune = 5', the initial condition of the modified sketch.)"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Aeleana" by Manuel Barbadillo
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Clay Shirky - OSI/MIT license (http://recodeproject/license).
*/

let tune = 5;
let tuneStep = 5;

function setup() {
  createCanvas(400, 400);
}

function draw() {
  drawPattern(0, 0, 200, true, 0);
  drawPattern(200, 0, 200, false, PI/2);
  drawPattern(0, 200, 200, false, -PI/2);
  drawPattern(200, 200, 200, true, PI);
}

function drawPattern(x, y, Size, black, angle) {
  let pg = createGraphics(200, 200);
  pg.noStroke();
  pg.background(black ? 0 : 255);
  pg.push();
  pg.translate(Size/2, Size/2);
  pg.rotate(angle);
  pg.fill(black ? 255 : 0);
  pg.rect(-125, -100, Size + tune, Size, tune, tune);
  pg.fill(black ? 0 : 255);
  pg.rect(-125, -100, Size, Size - tune, tune, tune);

  for (let i = 0; i < 6; i++) {
    black = !black;
    pg.fill(black ? 0 : 255);
    pg.rect(-125, -125, Size/2 + tune, 175 - i * tune, tune, tune);
  }

  for (let i = 0; i < 4; i++) {
    black = !black;
    pg.fill(black ? 0 : 255);
    pg.rect(0, -Size/2 + i * tune, Size/2 - i * tune, (i == 0) ? Size/2 : Size - (2 * i) * tune, (Size/2 - i * tune > tune) ? tune : 15, (Size/2 - i * tune > tune) ? tune : 15);
  }

  pg.pop();

  image(pg, x, y);
}

function mousePressed() {
  tune += tuneStep;
}
</script>
