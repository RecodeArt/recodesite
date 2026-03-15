---
title: "Untitled 1"
translator: "Chris Allick"
translator_url: "http://chrisallick.com/"
slug: "chris-allick-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: "None"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various (Reiner Schneeberger and unnamed students)
Originally published in "Computer Graphics and Art" vol1 no4, 1976
Copyright (c) 2012 Chris Allick - OSI/MIT license (http://recodeproject/license).
*/

let num = 5;
let depth = 6;

let rects = [];

function setup() {
  createCanvas(500, 500);
  fill(255);
  stroke(0);
  strokeWeight(2);
  rects = [];
  createRects();
  frameRate(10);
}

function draw() {
  background(255);

  for(let i = 0; i < rects.length; i++) {
    let rect = rects[i];
    rect.update();
    rect.display();
  }
}

function createRects() {
  for (let r = 0; r < num; r++) {
    for (let c = 0; c < num; c++) {
      rects.push(new Rect(r*100, c*100, 100, 100, depth));
    }
  }
}

class Rect {
  constructor(_x, _y, _w, _h, _d) {
    this.w = _w;
    this.h = _h;
    this.d = _d;

    this.x = _x;
    this.y = _y;
    this.xoff = int(random(2, 20));
    this.yoff = int(random(2, 10));

    this.xd = random(-1, 1);
    this.yd = random(-1, 1);
  }

  update() {
    this.xoff += this.xd;
    this.yoff -= this.yd;

    if(this.xoff > 18 || this.xoff < 2) {
      this.xd = -this.xd;
    }

    if(this.yoff > 18 || this.yoff < 2) {
      this.yd = -this.yd;
    }
  }

  display() {
    stroke(0);
    fill(255);
    for(let i = 0; i < this.d; i++) {
      rect(this.x + (this.xoff * i), this.y + (this.yoff * i), this.w - (20 * i), this.h - (20 * i));
    }
  }
}
</script>
