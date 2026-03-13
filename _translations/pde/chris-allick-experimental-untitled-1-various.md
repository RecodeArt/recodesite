---
title: "Untitled 1"
translator: "Chris Allick"
translator_url: "http://chrisallick.com/"
slug: "chris-allick-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: "None"
runs_in_browser: 
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various (Reiner Schneeberger and unnamed students)
Originally published in "Computer Graphics and Art" vol1 no4, 1976
Copyright (c) 2012 Chris Allick - OSI/MIT license (http://recodeproject/license).
*/

          int num = 5;
          int depth = 6;

          ArrayList rects;

          void setup() {
            size( 500, 500 );
            fill( 255 );
            stroke( 0 );
            strokeWeight( 2 );
            rects = new ArrayList();
            createRects();
            frameRate(10);
          }

          void draw() {
            background( 255 );

            for( int i = 0; i < rects.size(); i++ ) {
              Rect rect = (Rect) rects.get(i);
              rect.update();
              rect.display();
            }
          }

          void createRects() {
            for ( int r = 0; r < num; r++ ) {
              for ( int c = 0; c < num; c++ ) {
                rects.add(new Rect( r*100, c*100, 100, 100, depth ) ); 
              }
            }
          }

          class Rect {
            int w, h, d;
            
            float x, y, xoff, yoff, xd, yd;
            
            Rect( float _x, float _y, int _w, int _h, int _d ) {
              x = _x;
              y = _y;
              w = _w;
              h = _h;
              d = _d;
              
              xoff = (int)random(2,20);
              yoff = (int)random(2,10);

              xd = random(-1,1);
              yd = random(-1,1);
            }
            
            void update() {
              xoff += xd;
              yoff -= yd;

              if( xoff > 18 || xoff < 2 ) {
                xd = -xd;
              }
              
              if( yoff > 18 || yoff < 2 ) {
                yd = -yd;
              }
            }

            void display() {
              stroke( 0 );
              fill( 255 );
              for( int i = 0; i < d; i++ ) {
                rect( x+(xoff*i), y+(yoff*i), w-(20*i), h-(20*i) );
              }
            } 
          }
