---
title: "Diamond Theory"
translator: "Isaac Gierard"
translator_url: "http://www.gierard.com/"
slug: "isaac-direct-diamond-theory-steven-h-cullinane"
artwork_slug: "v2n1-diamond-theory"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Diamond Theory" by Steven H Cullinane
Originally published in "Computer Graphics and Art" vol2 no1, 1977
Copyright (c) 2012 Isaac Gierard - OSI/MIT license (http://recodeproject/license).
*/

let c1;
let c2;
let d;

function setup(){
  c1 = color(255);
  c2 = color(0);

  background(255);
  let spacing = 16;
  let rows = 10;
  let cols = 10;

  d = new Diamond(4);

  createCanvas(
    int((d.drawScale * d.qSide + spacing) * cols) + spacing,
    int((d.drawScale * d.qSide + spacing) * rows) + spacing
  );

  translate(spacing, spacing);
  for(let y = 0; y < rows; y++){
      push();
      for(let x = 0; x < cols; x++){
        d.generate();
        d.draw();
        translate(d.drawScale * d.qSide + spacing, 0);
      }
      pop();
      translate(0, d.drawScale * d.qSide + spacing);
    }
}

class Diamond {
  constructor(qSide) {
    this.qSide = qSide;
    this.drawScale = 10;
    this.items = [];
    this.generate();
  }

  generate() {
    // "Latin" generation
    this.items = [];
    let testSet = new Set();
    for(let i = 0; i < this.qSide * this.qSide; i++){
      testSet.clear();
      let v = int(random(0, this.qSide));
      let again = false;
      let x = i % this.qSide;
      let y = int(i / this.qSide);

      do {
        again = false;
        for(let j = 0; j < x; j++){
          let tv = this.items[y * this.qSide + j];
          testSet.add(tv);
        }
        for(let j = 0; j < y; j++){
          let tv = this.items[j * this.qSide + x];
          testSet.add(tv);
        }
        do {
          v = int(random(0, this.qSide));
        } while(testSet.has(v) && testSet.size < this.qSide);
      } while(again);
      this.items.push(v);
    }

    let r = int(random(0, 3));
    if(r == 0){
      this.mirror(int(random(0, 2)));
    } else if(r == 1){
      this.invert(int(random(0, 2)));
    } else {
      this.loop();
    }
  }

  loop() {
    this.mirror(0);
    this.mirror(1);
  }

  mirror(axis) {
    if(axis == 0){
      for(let x = 0; x < this.qSide / 2; x++){
        for(let y = 0; y < this.qSide; y++){
          let tx = this.qSide - 1 - x;
          this.items[y * this.qSide + tx] = this.mirrorElementX(this.items[y * this.qSide + x]);
        }
      }
    } else {
      for(let y = 0; y < this.qSide / 2; y++){
        for(let x = 0; x < this.qSide; x++){
          let ty = this.qSide - 1 - y;
          this.items[ty * this.qSide + x] = this.mirrorElementY(this.items[y * this.qSide + x]);
        }
      }
    }
  }

  invert(axis) {
    if(axis == 0){
      for(let x = 0; x < this.qSide / 2; x++){
        for(let y = 0; y < this.qSide; y++){
          let tx = this.qSide - 1 - x;
          this.items[y * this.qSide + tx] = this.invertElement(this.items[y * this.qSide + x]);
        }
      }
    } else {
      for(let y = 0; y < this.qSide / 2; y++){
        for(let x = 0; x < this.qSide; x++){
          let ty = this.qSide - 1 - y;
          this.items[ty * this.qSide + x] = this.invertElement(this.items[y * this.qSide + x]);
        }
      }
    }
  }

  mirrorElementX(e) {
    if(e == 1) return 2;
    if(e == 2) return 1;
    if(e == 0) return 3;
    if(e == 3) return 0;
    return 0;
  }

  mirrorElementY(e) {
    if(e == 1) return 0;
    if(e == 0) return 1;
    if(e == 3) return 2;
    if(e == 2) return 3;
    return 0;
  }

  invertElement(e) {
    if(e == 1) return 3;
    if(e == 3) return 1;
    if(e == 2) return 0;
    if(e == 0) return 2;
    return 0;
  }

  draw() {
    push();
    for(let y = 0; y < this.qSide; y++){
      push();
      for(let x = 0; x < this.qSide; x++){
        this.drawTri(this.items[this.qSide * y + x], this.drawScale);
        translate(this.drawScale, 0);
      }
      pop();
      translate(0, this.drawScale);
    }
    pop();
  }

  drawTri(orientation, s) {
   noStroke();
   fill(c1);
   rect(0, 0, s, s);
   fill(c2);
   switch(orientation){
     case 0:
       /*
              *
             **
       */
       beginShape();
       vertex(s, 0);
       vertex(s, s);
       vertex(0, s);
       endShape(CLOSE);
       break;
      case 1:
       /*
             **
              *
       */
       beginShape();
       vertex(0, 0);
       vertex(s, 0);
       vertex(s, s);
       endShape(CLOSE);
       break;
     case 2:
       /*
             **
             *
       */
       beginShape();
       vertex(s, 0);
       vertex(0, 0);
       vertex(0, s);
       endShape(CLOSE);
       break;
      case 3:
       /*
             *
             **
       */
       beginShape();
       vertex(0, 0);
       vertex(0, s);
       vertex(s, s);
       endShape(CLOSE);
       break;
   }
  }
}
</script>
