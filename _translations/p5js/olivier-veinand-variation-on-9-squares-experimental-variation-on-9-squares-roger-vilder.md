---
title: "Variation on 9 Squares"
translator: "Olivier Veinand"
translator_url: ""
slug: "olivier-veinand-variation-on-9-squares-experimental-variation-on-9-squares-roger-vilder"
artwork_slug: "v1n2-variation-on-9-squares"
category: "experimental"
description: 'Based on work from Gerald Kogler I just added randomness in line length You can use key "a" to animate'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Variation On 9 Squares" by Roger Vilder
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2020 Olivier Veinand - OSI/MIT license (http://recodeproject/license).
*/

/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Variation on 9 Squares" by Roger Vilder
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Gerald Kogler - OSI/MIT license (http://recodeproject/license).


Based on work from Gerald Kogler
I just added randomness in line length
You can use key "a" to animate

*/

let s = 480;        // size of sketch
let num = 3;        // num of lines and columns in grid
let margin = 30;    // margin around rectangles areas
let overlap = 40;   // overlap of reactangle areas
let ease = 0.3;     // easing/division factor for non/linear distribution
let mode = 'e';     // mode 'l'==linear, 'e'==exponential distribution
let bg = 0;
let r;
let squares = [];

function setup() {
  createCanvas(480, 480);
  noFill();
  stroke(255);
  r = ((width - 2 * margin) / num) / 2 + overlap / num;

  // make instances of squares
  for (let y = 0; y < num; y++) {
    for (let x = 0; x < num; x++) {
      squares.push(new Square(x, y, ((x + y * num) % 2 == 0)));
    }
  }
  dessine();
}

function dessine() {
  background(bg);
  for (let i = 0; i < num * num; i++) {
    squares[i].draw();
  }
}

let animate = false;

function draw() {
  if (animate) {
    dessine();
  }
}

function keyPressed() {
  if (key == 'a') {
    animate = !animate;
  }
  if (key == 's') {
    save("RogerVilder-" + mode + ease + ".png");
  } else if (key == 'b') {
    if (bg == 0) {
      bg = 255;
      stroke(0);
    } else {
      bg = 0;
      stroke(255);
    }
  } else if (key == 'm') {
    if (mode == 'l') mode = 'e';
    else mode = 'l';
  } else if (key == '+') {
    if (ease > 0.15) ease -= 0.1;
  } else if (key == '-') {
    if (ease < 1.0) ease += 0.1;
  }
  dessine();
}


function theLine(x1, y1, x2, y2) {
  if (x1 == x2) {
    for (let y = y1; y < y2; y++) {
      stroke(255);
      point(x1, y);
    }
  } else {
    for (let x = x1; x < x2; x++) {
      stroke(255);
      point(x, y1);
    }
  }
}

class Square {
  constructor(x, y, hor) {
    this.x = x;       // position in grid
    this.y = y;
    this.hor = hor;   // orientation of squares
  }

  draw() {
    let step = 0;
    for (let angle = 0; angle <= HALF_PI; angle += step) {
      if (mode == 'e') step = (HALF_PI + 0.1 - angle) * ease;
      else step = HALF_PI / (ease * 10);

      let cx = margin + this.x * (2 * r - overlap);
      let cy = margin + this.y * (2 * r - overlap);
      let sx, sy;
      if (this.hor) {
        sx = r + r * cos(angle);
        sy = r + r * sin(angle);
      } else {
        sx = r + r * sin(angle);
        sy = r + r * cos(angle);
      }
      let sw = (r - sx) * 2;
      let sh = (r - sy) * 2;
      line(cx + sx + random(20), cy + sy, cx + sx + sw - random(20), cy + sy);
      line(cx + sx + random(20), cy + sy + sh, cx + sx + sw - random(20), cy + sy + sh);
      line(cx + sx, cy + sy + random(20), cx + sx, cy + sy + sh - random(20));
      line(cx + sx + sw, cy + sy + random(20), cx + sx + sw, cy + sy + sh - random(20));
    }
  }
}
</script>
