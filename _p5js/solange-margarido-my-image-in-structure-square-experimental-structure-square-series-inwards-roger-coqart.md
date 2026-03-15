---
title: "My Image in Structure Square"
translator: "Solange Margarido"
translator_url: ""
slug: "solange-margarido-my-image-in-structure-square-experimental-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "experimental"
description: 'Transform an image to Structure Square look. Derived from Kyle McDonald''s translation of Roger Coqart''s "Structure Square Series Inwards".'
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure Square Series Inwards" by Roger Coqart
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2021 Solange Margarido - OSI/MIT license (http://recodeproject/license).
*/

let side = 24; // Change this value to determine the size of the squares
let lines = 8;
let n = lines * 2 + 1;
let margin = Math.floor(side / 2);
let offset = side + margin;
let canvas_size = (n + 1) * offset;
let enabled = [];
let detail;
let img;
let img_name = "apple.jpg"; // Path of the image you want to transform

function preload() {
  img = loadImage(img_name);
}

function setup() {
  // If detail is smaller than the side it allows us to map less pixels of the image to more squares
  detail = Math.floor(side / 1.8);

  let x_size = Math.floor(img.width / detail);
  let y_size = Math.floor(img.height / detail);

  createCanvas((x_size * side) + (x_size * margin) + margin * 3,
               (y_size * side) + (y_size * margin) + margin * 3);

  colorMode(HSB, 360, 100, 100);
  noLoop();

  // Initialize enabled array
  for (let i = 0; i < lines; i++) {
    enabled[i] = false;
  }
}

function draw() {
  background(360, 0, 100);
  translate(side, side);

  let x_size = Math.floor(img.width / detail);
  let y_size = Math.floor(img.height / detail);
  console.log(x_size);
  console.log(y_size);

  img.loadPixels();
  for (let y = 0; y < y_size; y++) {
    for (let x = 0; x < x_size; x++) {
      // Average of a group of pixels
      let total_brightness = 0;
      for (let i = 0; i < detail; i++) {
        for (let j = 0; j < detail; j++) {
          let idx = ((y * detail) + i) * img.width + ((x * detail) + j);
          total_brightness += brightness(img.pixels[idx]);
        }
      }

      let average_brightness = total_brightness / (detail * detail);

      // Enable some lines
      let total = Math.floor((1 - (average_brightness / 100)) * lines);
      for (let i = 0; i < lines; i++) {
        enabled[i] = i < total;
      }

      // Shuffle the enabled lines
      for (let i = 0; i < lines; i++) {
        let swap = enabled[i];
        let j = Math.floor(random(lines));
        enabled[i] = enabled[j];
        enabled[j] = swap;
      }

      // Draw all enabled lines
      push();
      strokeWeight(2);
      translate(x * offset, y * offset);
      rect(0, 0, side, side);
      strokeWeight(3);
      if (enabled[0]) line(0, side / 2, side, side / 2);
      if (enabled[1]) line(side / 2, 0, side / 2, side);
      if (enabled[2]) line(0, 0, side, side);
      if (enabled[3]) line(0, side, side, 0);
      if (enabled[4]) line(0, side / 2, side / 2, 0);
      if (enabled[5]) line(side / 2, 0, side, side / 2);
      if (enabled[6]) line(side, side / 2, side / 2, side);
      if (enabled[7]) line(side / 2, side, 0, side / 2);
      pop();
    }
  }

  save(img_name); // The new image will be saved in your project folder
}
</script>
