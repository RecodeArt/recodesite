---
title: "Topographic Form"
translator: "Jay Kominek"
translator_url: "https://github.com/jkominek"
slug: "jay-kominek-topographic-form-direct-topographic-form-sture-johannesson"
artwork_slug: "v1n2-topographic-form"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Topographic Form" by Sture Johannesson
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2014 Jay Kominek - OSI/MIT license (http://recodeproject/license).
*/

// by Sture Johannesson and Sten Kallin, Malmo, Sweden

class RaisedArc {
  constructor(x_, y_, r_, width_, start_, stop_, height_) {
    this.cx = x_;
    this.cy = y_;
    this.r = r_;
    this.width = width_ / 2.0;
    this.height = height_;
    this.start = start_;
    this.stop = stop_;
  }

  // the arc is effectively -pi/2 to pi/2 of cosine,
  // stretched to the specified width and height, and extruded
  // along the arc centered at x,y and r units from there,
  // run from start radians to stop radians.
  computeHeight(px, py) {
    let rx = px - this.cx;
    let ry = py - this.cy;

    let theta = atan2(ry, rx) + PI;
    let distance = sqrt(rx * rx + ry * ry);

    if (this.start <= theta && theta <= this.stop) {
      let wp = abs(this.r - distance) / this.width;

      // you can comment this out to get "ringing"
      // from the arcs.
      if (wp >= 1.0) wp = 1.0;

      return this.height * cos(PI/2.0 * wp);
    } else {
      return 0.0;
    }
  }
}

let arcs;
let sh = 600;
let sw = 3 * (sh/2);

function setup() {
  arcs = [
    new RaisedArc(0, 0, 15, 9, 0, 2*PI, 10),
    new RaisedArc(-30, 0, 15, 9, PI, 2*PI, 10),
    new RaisedArc(-30, 0, 15, 9, 0, PI/2, 10),
    new RaisedArc(30, 0, 15, 9, 0, 1.5*PI, 10)
  ];
  createCanvas(sw, sh, WEBGL);
  noFill();
  strokeWeight(0.8);
}

function draw() {
  // black on white
  background(255);
  stroke(0);

  // the XY plane is tilted, but it is hard to tell
  let rotation = 28.12 / 180.0 * PI;
  // because the projection is orthographic
  ortho();

  // scoot us to the middle
  translate(0, 0, 0);
  // scale things up. values made up to fit the window.
  scale((sw/2)/60*1.05, (sh/2)/41*1.05, 1.0);

  rotateX(rotation);

  beginShape();
  for (let iy = -41; iy < 41; iy++) {
    let fy = iy;

    // this flip flops the direction in which we're drawing.
    let fx_start = (iy % 2 != 0) ? -60.0 : 60.0;
    let fx_stop = -fx_start;
    let fx_step = (iy % 2 != 0) ? 1.0 : -1.0;

    for (let fx = fx_start;
         (iy % 2 != 0) ? (fx <= fx_stop) : (fx >= fx_stop);
         fx += fx_step) {
      let fz = 0.0;

      // height of our surface is the height of the tallest arc at that spot.
      for (let j = 0; j < 4; j++) {
        let h = arcs[j].computeHeight(fx, fy - 0.5);
        if (h > fz) {
          fz = h;
        }
      }

      // emit a vertex.
      vertex(fx, fy, fz);
    }
  }
  endShape();
}
</script>
