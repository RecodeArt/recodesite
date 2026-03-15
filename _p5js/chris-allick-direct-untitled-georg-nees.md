---
title: "Untitled 18"
translator: "Chris Allick"
translator_url: "http://chrisallick.com/"
slug: "chris-allick-direct-untitled-georg-nees"
artwork_slug: "v1n2-untitled18"
category: "direct"
description: "None"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Georg Nees
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Chris Allick - OSI/MIT license (http://recodeproject/license).
*/

           let radius = 150;
            let min, max;

            function setup() {
              createCanvas( 600, 600 );
              background( 255 );
              stroke( 0 );
              noFill();
              strokeWeight( 2 );
              min = 100;
              max = 300;
              drawCircles();
            }

            function draw() {}

            function drawCircles() {
             background( 255 );

             for( let r = 0; r < 2; r++ ) {
               for( let c = 0; c < 2; c++ ) {
                  push();
                    translate( 150+(300*r), 150+(300*c));
                    //ellipse( 0, 0, 300, 300 );
                    for( let i = 0; i < int(random(min,max)); i++ ) {
                      let a = random(0, TWO_PI);
                      let x1 = radius*cos(a);
                      let y1 = radius*sin(a);
                      a = random(0, TWO_PI);
                      let x2 = radius*cos(a);
                      let y2 = radius*sin(a);

                      line( x1, y1, x2, y2);
                    }
                  pop();
               }
             }
            }

            function mousePressed() {
              drawCircles();
            }
</script>
