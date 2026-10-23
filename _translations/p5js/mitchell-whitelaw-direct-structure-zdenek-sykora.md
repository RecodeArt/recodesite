---
title: "Structure"
translator: "Mitchell Whitelaw"
translator_url: "http://creative.canberra.edu.au/mitchell/"
slug: "mitchell-whitelaw-direct-structure-zdenek-sykora"
artwork_slug: "v1n2-structure"
category: "direct"
description: "Click in frame to refresh."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure" by Zdenek Sykora
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Mitchell Whitelaw - OSI/MIT license (http://recodeproject/license).
*/

let moduledim = 40;
let gridwidth = 11;
let gridheight = 22;

function setup() {
  createCanvas(440, 880);
  noLoop();
  ellipseMode(CENTER);
}


function draw() {
  noStroke();
  translate(moduledim / 2, moduledim / 2);
  for (let i = 0; i < gridwidth; i++) {
    for (let j = 0; j < gridheight; j++) {
      sykoraModule(floor(random(2)), floor(random(3)), floor(random(4)), i, j);
    }
  }
}


function sykoraModule(polarity, composition, orientation, gridx, gridy) {
  push();
  translate(gridx * moduledim, gridy * moduledim);
  rotate(orientation * TWO_PI / 4.0);
  translate(-moduledim / 2, -moduledim / 2);

  fill(polarity * 255); // bg fill
  rect(0, 0, moduledim, moduledim); // bg square

  fill(abs(polarity - 1) * 255); // reverse the fill

  arc(moduledim / 2, 0, moduledim, moduledim, 0, PI); // composition == 0; first arc

  if (composition == 1) { // more arcs
    arc(moduledim / 2, moduledim / 2, moduledim, moduledim, 0, PI); // second arc (aligned)
  } else if (composition == 2) {
    arc(moduledim / 2, moduledim, moduledim, moduledim, PI, TWO_PI); // second arc (mirrored);
  }
  pop();
}


function mousePressed() {
  redraw();
}
</script>
