---
title: "Structure"
translator: "Krystof Pesek"
translator_url: "http://kof.shellmix.com/"
slug: "krystof-pesek-experimental-structure-zdenek-sykora"
artwork_slug: "v1n2-structure"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure" by Zdenek Sykora
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Krystof Pesek - OSI/MIT license (http://recodeproject/license).
*/

let theta;
let plny;
let moznosti = [0, 90, 180, 270];
let r;

function setup() {
  createCanvas(576, 704);
  imageMode(CENTER);

  plny = createGraphics(32, 32);
  createShaped();

  theta = [];
  for (let i = 0; i < 3000; i++) {
    theta[i] = moznosti[floor(random(4))];
  }
}

function draw() {
  background(0);

  r = plny.width;

  let idx = 0;
  for (let y = 0; y <= height / plny.height; y++) {
    for (let x = 0; x <= width / plny.width; x++) {
      push();
      translate(x * r + plny.width/2, y * r + plny.height/2);
      rotate(radians(theta[idx]));
      theta[idx] += 0.004 * degrees(frameCount/200.0 * atan2(mouseY - y*r, mouseX - x*r));
      image(plny, 0, 0);
      pop();

      idx += 1;
    }
  }
}

function createShaped() {
  let W = plny.width;
  let H = plny.height;

  plny.fill(255);
  plny.noStroke();
  plny.arc(W/2, H/2, W - 2, H - 2, 0, PI);
}
</script>
