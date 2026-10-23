---
title: "Untitled - WG Wolfgang (Array)"
translator: "Jerome Herr"
translator_url: "https://www.facebook.com/AwesomeBrain"
slug: "jerome-herr-untitled-wg-wolfgang-array-direct-untitled-w-g-wolfgang"
artwork_slug: "v1n4-untitled-5"
category: "direct"
description: "No more than 4 same symbols in a row vertically and no more than 2 same symbols in a row horizontally. (Please delete my previous submission)"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by W G Wolfgang
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Jerome Herr - OSI/MIT license (http://recodeproject/license).
*/

let incr_x, incr_y, x, y, r;
let countLine = 0; // how many lines in a (vertical) row?
let countCross = 0; // how many crosses in a (vertical) row?
let margin = 15;
let counter = -1;
let isX = [];
let val;
let steps_x, steps_y; // number of rows and columns
let max = 4; // max number of symbols in a row, vertically!

function setup() {
  createCanvas(600, 600);
  background(255);
  strokeWeight(5);

  steps_x = 10; //number of columns
  steps_y = 12; //number of lines

  incr_x = width / steps_x;
  incr_y = height / steps_y;

  drawPattern();
}

function draw() {
}

function drawPattern() {
  background(255);
  isX = [];
  counter = -1;
  countLine = 0;
  countCross = 0;

  for (x = 0; x < width; x += incr_x) {
    for (y = incr_y/2; y < height; y += incr_y) {
      counter += 1;
      r = random(1);

      if (counter > 2 * steps_y - 1) {
        if (isX[counter - 2*steps_y] + isX[counter - steps_y] == 2) {
          val = 0;
        } else if (isX[counter - 2*steps_y] + isX[counter - steps_y] == 0) {
          val = 1;
        } else {
          if (r > 0.6) {
            val = 1;
          } else {
            val = 0;
          }
        }
      } else {
        if (r > 0.5) {
          val = 1;
        } else {
          val = 0;
        }
      }

      if (countLine == max) {
        val = 1;
        countLine = 0;
        countCross += 1;
      }
      if (countCross == max) {
        val = 0;
        countLine += 1;
        countCross = 0;
      }

      isX.push(val);

      if (isX[counter] == 1) {
        isCross();
      } else {
        isLine();
      }
    }
  }
}

function mouseClicked() {
  drawPattern();
}

function isCross() {
  line(x + 10, y + incr_y/2 - margin, x + incr_x - margin, y - incr_y/2 + margin);
  line(x + 10, y - incr_y/2 + margin, x + incr_x - margin, y + incr_y/2 - margin);
  countCross += 1;
  countLine = 0;
}

function isLine() {
  line(x + margin, y, x + incr_x - margin, y);
  countCross = 0;
  countLine += 1;
}
</script>
