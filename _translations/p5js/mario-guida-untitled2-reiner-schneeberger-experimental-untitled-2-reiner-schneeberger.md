---
title: "Untitled2_Reiner_Schneeberger"
translator: "Mario Guida"
translator_url: "http://www.marioguida.org/"
slug: "mario-guida-untitled2-reiner-schneeberger-experimental-untitled-2-reiner-schneeberger"
artwork_slug: "v3n2-untitled-2-schneeberger"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 2" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Mario Guida - OSI/MIT license (http://recodeproject/license).
*/

let W = 500;
let H = 500;
let dh0, dh1, dw0, dw1;
let block, ds;
let exp;
let mul_factor;
let sample_rate;
let block_space;

let obj;

function setup() {
  createCanvas(500, 500);
  block_space = 9;
  block = H / block_space;
  ds = block / 2;
  exp = 12;
  mul_factor = 1;
  sample_rate = 4;

  obj = new LineGroup();

  noLoop();
}

function draw() {
  background(255);

  let counter = 1;

  dw0 = 0;
  dw1 = W;
  dh0 = 0;
  dh1 = 0;

  for (let a = 0; a <= PI; a = a + (PI / sample_rate)) {
    let div = abs(cos(a)) + (exp - abs(cos(a)));
    dh0 = dh1;
    dh1 = dh0 + (mul_factor * block);
    obj.settings(dh0, dh1, dw0, dw1, block / div, 0);

    if (counter <= sample_rate / 2) {
      exp = exp / 2;
      mul_factor++;
    } else {
      exp = exp * 2;
      mul_factor--;
    }
    counter++;
  }

  dw0 = 0;
  dw1 = 0;
  let delta_s = 0;
  let space = 0;
  for (let i = 0; i < sample_rate; i++) {
    dh0 = (sample_rate - i) * block;
    dh1 = dh0 + (((2 * i) + 1) * block);
    dw0 = dw1;

    if (i == 0) {
      dw1 = dw0 + ((13 * W) / 100);
      delta_s = dw1 - dw0;
      space = delta_s / 28;
    } else {
      dw1 = dw0 + ((29 * W) / 100);
      delta_s = dw1 - dw0;
      space = delta_s / (60 - (16 * i));
    }
    obj.settings(dh0, dh1, dw0, dw1, space, 1);
  }
}

class LineGroup {
  constructor() {
    this.c = 0;
    this.space = 1;
    this.x = 0;
    this.y = 0;
    this.dx = 0;
    this.dy = 0;
    this.type = 0; // 0 = horizontal and 1 = vertical
  }

  settings(dh0, dh1, dw0, dw1, div, t) {
    this.x = dw0;
    this.y = dh0;
    this.dx = dw1;
    this.dy = dh1;
    this.nline = div;
    this.type = t;
    this.space = div;
    this.display();
  }

  display() {
    if (this.type == 0) {
      for (let i = this.y; i < this.dy - 1; i = i + this.space) {
        line(this.x, i, this.dx, i);
      }
    } else {
      for (let i = this.x; i < this.dx - 1; i = i + this.space) {
        line(i, this.y, i, this.dy);
      }
    }
  }
}
</script>
