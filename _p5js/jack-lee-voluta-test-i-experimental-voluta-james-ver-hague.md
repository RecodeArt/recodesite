---
title: "Voluta - test I"
translator: "Jack Lee"
translator_url: "https://www.behance.net/jack1999"
slug: "jack-lee-voluta-test-i-experimental-voluta-james-ver-hague"
artwork_slug: "v3n1-voluta"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Voluta" by James Ver Hague
Originally published in "Computer Graphics and Art" v3n1, 1978
Copyright (c) 2020 Jack Lee - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(700, 700, WEBGL);
}

function draw() {
  background(255);
  ambientLight(255, 255, 255);
  pointLight(250, 250, 250, 0, 0, 500);

  for (let i = 0; i < width; i += 10) {
    push();
    translate(
      i - width/2,
      sin(frameCount/40.0) * map(mouseY, 0, height, 0, i),
      0
    );
    rotateX(map(mouseX, 0, width, 0, i*5)/200.0 + (frameCount/30.0));
    fill(0, 15);
    stroke(200);
    box(10, 250, 250);
    pop();
  }
}
</script>
