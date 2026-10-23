---
title: "Recode Test IV"
translator: "Jack Lee"
translator_url: "https://www.behance.net/jack1999"
slug: "jack-lee-recode-test-iv-experimental-helikos-james-ver-hague"
artwork_slug: "v2n2-helikos"
category: "experimental"
description: "more translations of James Ver Hague: https://www.notion.so/Project-1-2858ef9356d448dd8454347d50afde31"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Helikos" by James Ver Hague
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2020 Jack Lee - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(700, 700, WEBGL);
}

function draw() {
  background(map(mouseY, 0, height, 0, 255));

  for (let i = 0; i < width; i += 10) {
    push();
    translate(
      i - width/2,
      sin(frameCount/40.0 + i/5) * i / map(mouseX, 0, width, 1, 10),
      0
    );
    rotateX(i/200.0 + (frameCount/30.0));
    fill(map(mouseY, 0, height, 255, 0));
    stroke(map(mouseY, 0, height, 0, 255));
    box(10, 100, 100);
    pop();
  }
}
</script>
