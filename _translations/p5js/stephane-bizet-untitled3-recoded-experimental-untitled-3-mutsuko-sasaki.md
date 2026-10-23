---
title: "Untitled3_Recoded"
translator: "Stéphane Bizet"
translator_url: ""
slug: "stephane-bizet-untitled3-recoded-experimental-untitled-3-mutsuko-sasaki"
artwork_slug: "v3n3-untitled-3-sasaki"
category: "experimental"
description: "The two function called f(t) and g(t) in the magazine are unknown. I tried a few functions with different parameters. Two parameters can be changed with mouseX and mouseY."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Mutsuko K. Sasaki
Originally published in "Computer Graphics and Art" v3n3, 1978
Copyright (c) 2013 Stéphane Bizet - OSI/MIT license (http://recodeproject/license).
*/

// For the Recode Project
// Stéphane Bizet 5/10/2013

let radius;
let xc;
let yc;
let nCircle = 9;
let x, y;

function setup() {
  createCanvas(800, 600);
  stroke(20, 50, 70);
  strokeWeight(5);
  xc = width / 2;
  yc = height / 2;
}

function draw() {
  background(255);

  for (let i = 0; i < nCircle; i++) {
    radius = (i + 1) * 20; // The radius starts on 20 and gets bigger for each loop

    for (let ang = 0; ang <= 360; ang += 0.2) { // A full rotation
      let rad = ang * PI / 180; // Transform ang in radians rather than degrees

      // Changes the radius depending on the angle and the size of the circle
      let radiusTransformX = 3 * radius / 2 + radius * (radius / (mouseY * 1000.0 / height)) * cos(2 * rad - 5.0 * mouseX / width);
      let radiusTransformY = radius + (radius / 2) * (1 - radius / 200);

      x = xc + (radiusTransformX * cos(rad));
      y = yc + (radiusTransformY * sin(rad));
      point(x, y);
    }
  }
}
</script>
