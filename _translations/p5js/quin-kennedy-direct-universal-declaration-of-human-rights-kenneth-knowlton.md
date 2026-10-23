---
title: "Universal Declaration of Human Rights"
translator: "Quin Kennedy"
translator_url: ""
slug: "quin-kennedy-direct-universal-declaration-of-human-rights-kenneth-knowlton"
artwork_slug: "v1n2-universal-declaration-of-human-rights"
category: "direct"
description: "Folder containing data files necessary for running this code can be found here: https://github.com/matthewepler/ReCode_Project/tree/master/quin_kennedy/recode_v1n2_universal_declaration_of_human_rights."
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">

/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Universal Declaration of Human Rights" by Kenneth Knowlton
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/
//image from: http://www.metro.co.uk/news/841183-photos-around-the-world-in-80-days-competition-winners

let f;
let use = 1; // 3 works well, just the font is too clean; 1 has a nice pixely font
let img, i, t;
let shade;

function setup() {
if (use === 0) {
createCanvas(686, 820, WEBGL);
} else if (use === 1) {
createCanvas(646, 818, WEBGL);
} else if (use === 2) {
createCanvas(686, 820, WEBGL);
} else if (use === 3) {
createCanvas(686, 819, WEBGL);
}
noLoop();

// Load assets
img = loadImage("girl_gaze_contrast1_small2.jpg");
shade = loadShader("frag.glsl");

if (use === 0) {
f = loadFont("Krungthep-10.vlw");
} else if (use === 1) {
f = loadFont("KufiStandardGK-10.vlw");
} else if (use === 2) {
f = loadFont("Krungthep-12.vlw");
}
}

function draw() {
// Create image graphics buffer
i = createGraphics(width, height);
i.background(0);
let srcWidth = width / (height / img.height);
i.image(img, -(img.width - srcWidth) / 2, 0, srcWidth, img.height);
i.filter(INVERT);

// Create text graphics buffer
t = createGraphics(width, height);
t.background(0);
if (f) {
t.textFont(f);
}
t.stroke(255);
t.textAlign(CENTER);

// Load and process text
loadStrings("Universal Declaration of Human Rights.txt", (lines) => {
let s = lines.join(" ");
let small = s;
let offset = 0;
let px = width / 2;
let py = 16;

    while (small.length > 0) {
      while (small.length > 0 && !lineJustify(small, px, py, width - 20, t)) {
        let lastSpace = small.lastIndexOf(' ');
        if (lastSpace === -1) {
          console.log("OH NO!");
          return;
        }
        small = small.substring(0, lastSpace);
      }
      py += 11;
      offset += small.length + 1;
      if (offset >= s.length) {
        break;
      }
      small = s.substring(offset);
    }

    // Composite images
    i.loadPixels();
    t.loadPixels();
    loadPixels();

    for (let k = 0; k < pixels.length; k++) {
      let ip = i.pixels[k];
      let tp = t.pixels[k];
      let r = red(ip);
      let g = green(ip);
      let b = blue(ip);
      let rt = red(tp);
      let gt = green(tp);
      let bt = blue(tp);

      pixels[k] = color((r * 3 / 4 + 0.25) * rt,
                        (g * 3 / 4 + 0.25) * gt,
                        (b * 3 / 4 + 0.25) * bt);
    }
    updatePixels();

    shader(shade);
    rect(0, 0, width, height);
    shader(shade);
    rect(0, 0, width, height);

});
}

// Thanks to https://forum.processing.org/topic/writing-text-without-line-word-breaks
function lineJustify(s, px, py, w, g) {
let tw = g.textWidth(s);
if (tw > w) {
return false;
}
if (tw === w) {
g.text(s, px, py);
return true;
}
let tokens = s.split(" ");
if (tokens.length <= 1) {
g.text(s, px, py);
return true;
}
let tow = 0;
for (let currS of tokens) {
tow += g.textWidth(currS);
}

let cx = px - w / 2;
let gap = w - tow;
let gutter = gap / (tokens.length - 1);
for (let i = 0; i < tokens.length; i++) {
cx += g.textWidth(tokens[i]) / 2;
g.text(tokens[i], cx, py);
cx += g.textWidth(tokens[i]) / 2 + gutter;
}
return true;
}
</script>
