---
title: "Wernher"
translator: "Paul May"
translator_url: ""
slug: "paul-may-direct-wernher-von-braun-e-t-manning"
artwork_slug: "v3n1-wernher-von-braun"
category: "direct"
description: "Image is a cropped version of full output."
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Wernher von Braun" by E.T. Manning
Originally published in "Computer Graphics and Art" vol2 no4, 1977
Copyright (c) 2012 Paul May - OSI/MIT license (http://recodeproject/license).
*/

// Photo of output of optical processor for spatial quantization. 24in x 18in


/* ---------------- GLOBALS ---------------------- */

let sketchname = "wehrner";
let original_img; // the original source image of Von Braun

/*
// full grey palette
let allowed_colours = [
 color(0, 0, 0), color(8, 8, 8), color(16, 16, 16), color(24, 24, 24), color(32, 32, 32),
 color(40, 40, 40), color(48, 48, 48), color(56, 56, 56), color(64, 64, 64), color(72, 72, 72),
 color(80, 80, 80), color(88, 88, 88), color(96, 96, 96), color(104, 104, 104), color(112, 112, 112),
 color(120, 120, 120), color(128, 128, 128), color(136, 136, 136), color(144, 144, 144), color(152, 152, 152),
 color(160, 160, 160), color(168, 168, 168), color(176, 176, 176), color(184, 184, 184), color(192, 192, 192),
 color(200, 200, 200), color(208, 208, 208), color(216, 216, 216), color(224, 224, 224), color(232, 232, 232),
 color(240, 240, 240), color(248, 248, 248), color(255, 255, 255)];
*/

// reduced grey palette
let allowed_colours = [
 color(0, 0, 0), color(8, 8, 8), color(16, 16, 16), color(24, 24, 24), color(32, 32, 32),
 color(40, 40, 40), color(48, 48, 48), color(56, 56, 56), color(64, 64, 64), color(72, 72, 72),
 color(80, 80, 80), color(88, 88, 88), color(96, 96, 96), color(104, 104, 104), color(112, 112, 112),
 color(120, 120, 120), color(128, 128, 128), color(136, 136, 136), color(144, 144, 144), color(152, 152, 152),
 color(160, 160, 160), color(168, 168, 168), color(255, 255, 255)];




/* ---------------- SETUP ---------------------- */

function setup() {
  // size(1920, 1080); // FHD
  // size(1360, 768); // HD
  // size(1280,720); // 720p
  // size(1093, 614); // QFHD
  createCanvas(800, 600); // 4:3 low res

  /* What is Quantization?

   From WikiPedia "a process that reduces
   the number of distinct colors used in an image, usually with the intention that the new
   image should be as visually similar as possible to the original image. Computer algorithms
   to perform color quantization on bitmaps have been studied since the 1970s.
   Color quantization is critical for displaying images with many colors on devices that can only
   display a limited number of colors, usually due to memory limitations, and enables efficient
   compression of certain types of images."

   http://en.wikipedia.org/wiki/Color_quantization

   */


  /* Load original image.

   Image caption: Dr. Wernher von Braun in his Office - Dr. Wernher von Braun is in his office, with an artist's concept
   of a lunar lander in background and models of Mercury-Redstone, Juno, and Saturn I. Dr. Wernher von Braun, the first
   MSFC Director, led a team of German rocket scientists, called the Rocket Team, to the United States, first to
   Fort Bliss/White Sands, later being transferred to the Army Ballistic Missile Agency at Redstone Arsenal in Huntsville, Alabama.
   Image source: http://space.about.com/od/rocketrybiographies/ig/Wernher-von-Braun-Pictures-Gal/Wernher-von-Braun-in-Office.htm
   Image retrieved: November 17th 2012

   */

  original_img = loadImage("data/wehrner_resized.jpg");
}

function imageLoaded() {
  original_img.loadPixels();

  /* Now that we have the image,
   loop through each pizel of the image
   calculate the distance between the colour of that pizel and each of our allowed colours
   populate the pixel array of our quantized_img with the colour that is closest
   */
  for (let x = 0; x < original_img.pixels.length; x++) {   // loop through each pixel of the image;
    let minDistance = 1000000;
    let minIndex = 10000;
    minDistance = 1000;
    minIndex = 0;
    for (let y = 0; y < allowed_colours.length; y++) {
      // calculate the distance between the colour of that pixel and each of our allowed colours
      let redDistance = red(allowed_colours[y]) - red(original_img.pixels[x]);
      let greenDistance = green(allowed_colours[y]) - green(original_img.pixels[x]);
      let blueDistance = blue(allowed_colours[y]) - blue(original_img.pixels[x]);
      let colourDistance = abs(sqrt(redDistance + greenDistance + blueDistance));
      // is this the smallest distance we've seen?
      if (colourDistance < minDistance) {
        minDistance = colourDistance;
        minIndex = y;
      }
    }
    // set the colour of the pixel in the image to the colour in our allowed colours
    original_img.pixels[x] = allowed_colours[minIndex];
  }
  original_img.updatePixels();
}

/* ---------------- DRAW ---------------------- */


function draw() {
  // map the size of the inputted image to our window size
  if (original_img) {
    image(original_img, 0, 0, map(original_img.width, 0, original_img.width, 0, width), map(original_img.height, 0, original_img.height, 0, height));
  }
}


/* ---------------- HANDY FUNCTIONS ---------------------- */

function keyPressed() {
  switch (key) {
  case 's':
    screenShot();
    break;
  }
}

function screenShot() {
  // take a timestamped screenshot
  let d = new Date();
  let dateString = d.toISOString().replace(/[:.]/g, '-');
  let fileName = dateString + "_" + millis() + "_" + sketchname + ".png";
  save(fileName);
  console.log("took screenshot: " + fileName);
}
</script>
