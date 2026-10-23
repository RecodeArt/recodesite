---
title: "Organic Illusion"
translator: "Leander Herzog"
translator_url: "http://www.leanderherzog.ch/"
slug: "leander-herzog-direct-organic-illusion-william-kolomyjec"
artwork_slug: "v2n3-organic-illusion"
category: "direct"
description: "Image is a cropped version of full output. Source document includes code excerpts."
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Organic Illusion" by William Kolomyjec
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Leander Herzog - OSI/MIT license (http://recodeproject/license).
*/

let williams;
let rows = 2, columns = 6, unit = 200;

function setup() {
  createCanvas(unit * columns, unit * rows);
  background(255);

  williams = [];
  for (let i = 0; i < columns; i++) {
    for (let j = 0; j < rows; j++) {
      williams[i + j] = new William(createVector(i * unit, j * unit));
    }
  }
}

class William {
  constructor(pos) {
    this.pos = pos;
    this.p = [];
    this.shift = createVector(random(-unit * 0.2, unit * 0.2), random(-unit * 0.2, unit * 0.2));
    this.res = round(unit * 0.1 * 2);
    this.m = round(unit * 0.1);
    this.radius = unit * 0.25;
    this.flex = 180;
    this.offset = random(-this.flex, this.flex);

    let tmp = createVector();
    let dir = createVector(this.m, 0);

    for (let i = 0; i < this.res; i++) {
      let angle = radians(map(i, 0, this.res, 0, 360) + this.offset);
      this.p[i] = createVector(
        this.pos.x + unit * 0.5 + sin(angle) * this.radius + this.shift.x,
        this.pos.y + unit * 0.5 + cos(angle) * this.radius + this.shift.y
      );
      this.p[i + this.res] = createVector(this.pos.x + tmp.x, this.pos.y + tmp.y);
      tmp.add(dir);

      if (i + 1 == this.res / 4) dir.set(0, this.m, 0);
      else if (i + 1 == this.res / 2) dir.set(-this.m, 0, 0);
      else if (i + 1 == this.res / 4 * 3) dir.set(0, -this.m, 0);
    }

    for (let i = 0; i < this.res; i++) {
      line(this.p[i].x, this.p[i].y, this.p[i + this.res].x, this.p[i + this.res].y);
    }
  }
}
</script>
