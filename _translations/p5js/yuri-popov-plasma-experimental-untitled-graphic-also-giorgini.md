---
title: "Plasma"
translator: "Yuri Popov"
translator_url: ""
slug: "yuri-popov-plasma-experimental-untitled-graphic-also-giorgini"
artwork_slug: "v2n2-untitled-graphic-also%20girogini"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled Graphic" by Also Giorgini
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2014 Yuri Popov - OSI/MIT license (http://recodeproject/license).
*/

let step = 400;
let pal = [];
let cls;

function setup() {
  createCanvas(800, 400);
  pixelDensity(1)
  let s1, s2;
  let shift = 254;

  for (let i = 0; i < 128; i++) {
    s1 = sin(i * PI / 25);
    s2 = sin(i * PI / 50 + PI / 4);
    pal[i] = color(s1 * shift, s2 * shift, 200 + s1 * shift);
  }

  cls = new Array(width * height);
  let period = 92.0;

  for (let x = 0; x < width; x++) {
    for (let y = 0; y < height; y++) {
      let a = step + step * sin(x / period);
      let b = step + step * cos(y / period);
      let c = step + step * sin(sqrt(x * x + y * y) / period);
      cls[x + y * width] = Math.trunc((a + b + c) / 4);
    }
  }
}

function draw() {
  loadPixels();
  for (let pixelCount = 0; pixelCount < cls.length; pixelCount++) {
    pixels[pixelCount * 4] = red(pal[(cls[pixelCount] + frameCount) & 127]);
    pixels[pixelCount * 4 + 1] = green(pal[(cls[pixelCount] + frameCount) & 127]);
    pixels[pixelCount * 4 + 2] = blue(pal[(cls[pixelCount] + frameCount) & 127]);
    pixels[pixelCount * 4 + 3] = 255;
  }
  updatePixels();
}
</script>
