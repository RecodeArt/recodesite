---
title: "Untitled 4 Random Experimentantions"
translator: "Iuri Kato"
translator_url: ""
slug: "iuri-kato-untitled-4-random-experimentantions-experimental-untitled-4-reiner-schneeberger"
artwork_slug: "v3n2-untitled-4-schneeberger"
category: "experimental"
description: 'Added randomizations to the Direct Translation on the gridSize and density variables. Every "Run" builds a different image.'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">

/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2014 Iuri Kato - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" vol3 no2, 1978
Copyright (c) 2012 Jon Bobrow - OSI/MIT license (http://recodeproject/license).
*/
//
// Untitled #5 is part of a 10 piece series, intended to test viewers
// perception of art and composition. The section is titled "Experimental
// Esthetics with Computer Graphics -- Analyses of Viewers Impressions
// of Computer Graphics."
//
//
// note: .f enforces float division, dividing by an int would automatically round down
// i.e. 1/2 = 0 , 1/2.f = .5

var gridSize, density


function setup(){
  createCanvas(400, 400);
  background(255);

  // interesting density for grid 20: 2.5; 3.5; 5.3; 6.02;
  gridSize = random(30);
  density = random(7);

  stroke(0);
  strokeWeight(1);
  let padding = gridSize / density;    // even spacing for lines

  let rows = height / gridSize;
  let cols = width / gridSize;

  for(let i = 0; i < rows; i++){        // iterate over the # of rows (top to bottom)
    for(let j = 0; j < cols; j++){      // iterate over the # of columns (left to right)

      push();
      translate(j * gridSize, i * gridSize);      // move to grid location
      translate(gridSize / 2, gridSize / 2);  // move to rotate around center
      if(random(1) < 0.5)
        rotate(PI / 2);        // rotate vertical or horizontal
      else
        rotate(PI);

      for(let k = 0; k < density; k++){          // draw # of lines based on density with even spacing
        let _x = (k - density / 2) * padding;
        line(_x, -gridSize / 2, _x, gridSize / 2);
        //rect(_x, -gridSize/2, 5,5) //checking start position of the line
      }
      pop();
    }
  }
}


</script>
