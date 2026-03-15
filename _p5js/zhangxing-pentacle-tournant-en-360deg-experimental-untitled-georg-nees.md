---
title: "pentacle tournant en 360°"
translator: "zhangxing"
translator_url: ""
slug: "zhangxing-pentacle-tournant-en-360deg-experimental-untitled-georg-nees"
artwork_slug: "v1n2-untitled18"
category: "experimental"
description: "Après untitled de George nees, le rond est créé par les lignes. Cela me fait penser au concept du Kandinsky, le rond est un carré qui tourne sans fini. Donc j'ai crée plusieurs pentacles qui tournent pour avoir les différents ronds, enfin obtenir un dessin graphique"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Georg Nees
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2015 zhangxing - OSI/MIT license (http://recodeproject/license).
*/

let num = 2;
let step = 10;
let centx, centy;
let pArr;

function setup() {
  createCanvas(500, 500);
  frameRate(12);
  clearBackground();

  centx = width / 2;
  centy = height / 2;

  pArr = [];
  for (let i = 0; i < num; i++) {
    pArr[i] = new Particle(i);
  }
}

function clearBackground() {
  background(255);
  // graph paper
  let gap = 10;
  strokeWeight(1);
  stroke(140, 40);
  for (let x = 0; x < width; x += gap) {
    line(x, 0, x, height);
  }
  for (let y = 0; y < height; y += gap) {
    line(0, y, width, y);
  }
}

function draw() {
  // clearBackground();
  for (let i = 0; i < num; i++) {
    pArr[i].update();
  }
}

class Particle {
  constructor(num) {
    this.id = num;
    this.init();
  }

  trace(str) {
    // console.log("Particle " + this.id + ": " + str);
  }

  init() {
    this.trace("init");
    this.count = 0;
    this.step = 10;
    this.life = 720;
    this.angle = 0;
    this.radius = random(width * 2) + 50;

    this.origx = centx + (this.radius * cos(this.angle));
    this.origy = centy + (this.radius * sin(this.angle));
    this.x1 = this.origx;
    this.y1 = this.origy;

    this.rd = int(random(255));
    // this.gr = int(random(255));
    // this.bl = int(random(255));
    this.bl = this.gr = this.rd;  // grey
  }

  update() {
    this.count += this.step;
    this.angle = this.count;
    // project x2,y2 from x1,y1, and draw a line to it
    this.x2 = centx + (this.radius * cos(this.angle));
    this.y2 = centy + (this.radius * sin(this.angle));
    // draw line to it
    strokeWeight(1);
    stroke(this.rd, this.gr, this.bl);
    line(this.x1, this.y1, this.x2, this.y2);
    // reset for next update
    this.x1 = this.x2;
    this.y1 = this.y2;
    // expiration
    if (this.count >= this.life) {
      this.init();
    }
  }
}
</script>
