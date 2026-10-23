---
title: "v1n3untitled-7"
translator: "Jan Vantomme"
translator_url: "http://vormplus.be/"
slug: "jan-vantomme-v1n3untitled-7-direct-untitled-7-belfort-group"
artwork_slug: "v1n3-untitled-7"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 7" by Belfort Group
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2013 Jan Vantomme - OSI/MIT license (http://recodeproject/license).
*/

let blockWidth = 10;
let blockHeight = 10;

let h1, h2, h3;
let probability;

function setup() {
  createCanvas(800, 800);

  h1 = floor(random(2, 20)) * 2;
  h2 = floor(random(2, 20)) * 2;
  h3 = 80 - h1 - h2;
  probability = floor(random(30, 40));
}

function draw() {
  background(0);

  for (let x = 0; x < width; x += blockWidth) {
    if (random(100) < probability) {
      for (let i = 0; i < h1; i += 2) {
        push();
        translate(x, i * blockHeight);
        rect(0, 0, blockWidth, blockHeight);
        pop();
      }
    }
  }

  for (let x = 0; x < width; x += blockWidth) {
    if (random(100) < probability) {
      for (let i = 0; i < h2; i += 2) {
        push();
        translate(x, i * blockHeight + h1 * blockHeight);
        rect(0, 0, blockWidth, blockHeight);
        pop();
      }
    }
  }

  for (let x = 0; x < width; x += blockWidth) {
    if (random(100) < probability) {
      for (let i = 0; i < h3; i += 2) {
        push();
        translate(x, i * blockHeight + (h1 + h2) * blockHeight);
        rect(0, 0, blockWidth, blockHeight);
        pop();
      }
    }
  }

  noLoop();
}

function mousePressed() {
  h1 = floor(random(2, 20)) * 2;
  h2 = floor(random(2, 20)) * 2;
  h3 = 80 - h1 - h2;
  probability = floor(random(30, 40));

  loop();
}
</script>
