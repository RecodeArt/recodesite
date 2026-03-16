---
title: "Equidistant Space"
translator: "Daniel Howe"
translator_url: "http://rednoise.org/~dhowe/"
slug: "daniel-howe-equidistant-space-direct-equidistant-space-peter-milojevic"
artwork_slug: "v3n2-equidistant-space"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">

// ///////////////////////////////////////////////////
// For the ReCode Project - http://recodeproject.com
// ///////////////////////////////////////////////////
// From Computer Graphics and Art vol3 no2 pg 11
// "Equidistant Space" by Peter Milojevic  (direct)
// ///////////////////////////////////////////////////
// Daniel C. Howe (Delaunay code from Marcus Appel)
// ///////////////////////////////////////////////////

let nodes, edges, tris;
let actE, hullStart, index;
let dt;

function setup() {

  frameRate(10);
  createCanvas(580, 580);
  dt = new Delaunay(45);
}

function draw() {

  if (keyIsPressed && key === ' ') return;

  update();

  background(255);
  strokeWeight(2);
  rect(0, 0, width - 1, height - 1);

  let tcx, tcy;
  for (let i = 0; i < edges.length; i++) {

    let e = edges[i], ee = e.invE;
    if (ee == null || ee.inT == null) {

      tcx = e.inT.c_cx - e.p2.y + e.p1.y;
      tcy = e.inT.c_cy - e.p1.x + e.p2.x;
    }
    else {
      tcx = ee.inT.c_cx;
      tcy = ee.inT.c_cy;
    }
    line(e.inT.c_cx, e.inT.c_cy, tcx, tcy);
  }

  for (let i = 0; i < nodes.length; i++)
    ellipse(nodeAt(i).x - 1, nodeAt(i).y - 1, 2, 2);
}

function update() {

  background(255);

  // insert points at center
  let px = width/2;
  let py = height/2;
  dt.insert(px, py);
  dt.insert(px + 1, py);
  dt.insert(px + 1, py + 1);
  dt.insert(px, py + 1);

  // neighbors repulse each other
  let D = Math.trunc(Math.sqrt(nodes.length));
  for (let i = 0; i < edges.length; i++) {
    let edge = edges[i];
    clipEdge(edge.p1);
    clipEdge(edge.p2);
    let x = edge.p2.x - edge.p1.x;
    let y = edge.p2.y - edge.p1.y;
    let rr = x * x + y * y;
    if (rr < width * height / D / D)
      rr = floor(rr / 2);
    if (rr > 0) {
      rr *= D;
      x = width * x / rr;
      y = height * y / rr;
      edge.p1.x -= x;
      edge.p1.y -= y;
      edge.p2.x += x;
      edge.p2.y += y;
    }
  }

  // move/scale the graph to fit
  let tmpNodes = [];
  let xlo = width, ylo = height, xhi = 0, yhi = 0;
  for (let i = 0; i < nodes.length; i++) {
    let node = nodeAt(i);
    xlo = Math.min(xlo, node.x);
    ylo = Math.min(ylo, node.y);
    xhi = Math.max(xhi, node.x);
    yhi = Math.max(yhi, node.y);
    tmpNodes.push(node);
  }

  for (let i = 0;  i < 4; i++)
      tmpNodes.splice(Math.trunc(random(tmpNodes.length)), 1);

  dt.clear();
  for (let i = 0; i < tmpNodes.length; i++) {
    let node = tmpNodes[i];
    let nx = (node.x - xlo) * width / (xhi - xlo);
    let ny = (node.y - ylo) * height / (yhi - ylo);
    dt.insert(nx, ny);
  }
}

function clipEdge(p) {
  let d = dist(p.x, p.y, width/2, height/2);
  if (d > width/2) {
    p.x += (p.x < width/2) ? 1 : -1;
    p.y += (p.y < height/2) ? 1 : -1;
  }
}

function nodeAt(i) {
  return nodes[i];
}

/*
 * A port to Processing of
 * <a href=http://www.geo.tu-freiberg.de/~apelm/>Marcus Appel</a>'s
 * 'Delaunay Triangulation' routines
 */
class Delaunay {

    constructor(num) {
      tris = [];
      nodes = [];
      edges = [];
      for (let i = 0; i < num; i++)
        this.insert(Math.trunc(random(width/4, width * 0.75)), Math.trunc(random(height/4, height * 0.75)));
    }

    clear() {
      nodes = [];
      edges = [];
      tris = [];
    }

    insert(px, py) {
      let eid;
      let nd = new Node(px, py);
      nodes.push(nd);
      if (nodes.length < 3)
        return;
      if (nodes.length == 3) // create the first tri
      {
        let p1 = nodeAt(0), p2 = nodeAt(1), p3 = nodeAt(2);
        let e1 = new Edge(p1, p2);
        if (e1.onSide(p3) == 0) {
          nodes.pop();
          return;
        }
        if (e1.onSide(p3) == -1) // right side
        {
          p1 = nodes[1];
          p2 = nodes[0];
          e1.updateEdge(p1, p2);
        }
        let e2 = new Edge(p2, p3), e3 = new Edge(p3, p1);
        e1.setNextH(e2);
        e2.setNextH(e3);
        e3.setNextH(e1);
        hullStart = e1;
        tris.push(new Triangle(edges, e1, e2, e3));
        return;
      }
      actE = edges[0];
      if (actE.onSide(nd) == -1) {
        if (actE.invE == null)
          eid = -1;
        else
          eid = this.searchEdge(actE.invE, nd);
      } else
        eid = this.searchEdge(actE, nd);
      if (eid == 0) {
        nodes.pop();
        return;
      }
      if (eid > 0)
        this.expandTri(actE, nd, eid); // nd is inside or on a triangle
      else
        this.expandHull(nd); // nd is outside convex hull
    }

    delete(px, py) {

      if (nodes.length <= 3) return; // not for single tri

      let nd = this.nearest(px, py);
      if (nd == null)
        return; // not found
      let nIndex = nodes.indexOf(nd);
      nodes.splice(nIndex, 1);
      let e, ee, start;
      start = e = nd.anEdge.mostRight();
      let nodetype = 0, idegree = -1;

      if (edges == null || index.length < edges.length)
        index = new Array((edges == null ? 0 : edges.length) + 100);

      while (nodetype == 0) {
        let eeIndex = edges.indexOf(ee = e.nextE);
        edges.splice(eeIndex, 1);
        index[++idegree] = ee;
        ee.asIndex();
        let tIndex = tris.indexOf(e.inT);
        tris.splice(tIndex, 1); // delete triangles involved
        let eIndex = edges.indexOf(e);
        edges.splice(eIndex, 1);
        let eeNextEIndex = edges.indexOf(ee.nextE);
        edges.splice(eeNextEIndex, 1);
        e = ee.nextE.invE; // next left edge
        if (e == null) nodetype = 2; // nd on convex hull
        if (e == start) nodetype = 1; // inner node
      }

      // generate new tris and add to triangulation
      let cur_i = 0, cur_n = 0;
      let last_n = idegree;
      let e1 = null, e2 = null, e3;
      while (last_n >= 1) {
        e1 = index[cur_i];
        e2 = index[cur_i + 1];
        if (last_n == 2 && nodetype == 1) {
          tris.push(new Triangle(edges, e1, e2, index[2]));
          this.swapTest(e1, e2, index[2]); // no varargs in pjs
          break;
        }
        if (last_n == 1 && nodetype == 1) {
          index[0].invE.rinkSymm(index[1].invE);
          index[0].invE.asIndex();
          index[1].invE.asIndex();
          this.swapTest(index[0].invE);
          break;
        }
        if (e1.onSide(e2.p2) == 1) // left side
        {
          e3 = new Edge(e2.p2, e1.p1);
          cur_i += 2;
          index[cur_n++] = e3.makeSymm();
          tris.push(new Triangle(edges, e1, e2, e3));
          this.swapTest(e1, e2);
        } else
          index[cur_n++] = index[cur_i++];

        if (cur_i == last_n)
          index[cur_n++] = index[cur_i++];

        if (cur_i == last_n + 1) {
          if (last_n == cur_n - 1)
            break;
          last_n = cur_n - 1;
          cur_i = cur_n = 0;
        }
      }
      if (nodetype == 2) // reconstruct convex hull
      {
        index[last_n].invE.mostLeft().setNextH(hullStart = index[last_n].invE);
        for (let i = last_n; i > 0; i--) {
          index[i].invE.setNextH(index[i - 1].invE);
          index[i].invE.setInvE(null);
        }
        index[0].invE.setNextH(start.nextH);
        index[0].invE.setInvE(null);
      }
    }

    expandTri(e, nd, type) {
      let e1 = e, e2 = e1.nextE, e3 = e2.nextE;
      let p1 = e1.p1, p2 = e2.p1, p3 = e3.p1;

      if (type == 2) {// nd is inside of the triangle

        let e10 = new Edge(p1, nd), e20 = new Edge(p2, nd), e30 = new Edge(p3, nd);
        e.inT.removeEdges(edges);
        let tIndex = tris.indexOf(e.inT);
        tris.splice(tIndex, 1); // remove old triangle
        tris.push(new Triangle(edges, e1, e20, e10.makeSymm()));
        tris.push(new Triangle(edges, e2, e30, e20.makeSymm()));
        tris.push(new Triangle(edges, e3, e10, e30.makeSymm()));
        this.swapTest(e1, e2, e3); // swap test for the three new triangles
      }
      else {// nd is on the edge e

        let e4 = e1.invE;
        if (e4 == null || e4.inT == null) // one triangle involved
        {
          let e30 = new Edge(p3, nd), e02 = new Edge(nd, p2),
            e10 = new Edge(p1, nd), e03 = e30.makeSymm();
          e10.asIndex();
          e1.mostLeft().setNextH(e10);
          e10.setNextH(e02);
          e02.setNextH(e1.nextH);
          hullStart = e02;
          let tIndex = tris.indexOf(e1.inT);
          tris.splice(tIndex, 1); // remove oldtriangle
          let eIndex = edges.indexOf(e1);
          edges.splice(eIndex, 1);
          edges.push(e10);// add two new triangles
          edges.push(e02);
          edges.push(e30);
          edges.push(e03);
          tris.push(new Triangle(e2, e30, e02));
          tris.push(new Triangle(e3, e10, e03));
          this.swapTest(e2, e3, e30); // swap test for the two new triangles
        } else // two triangle involved
        {
          let e5 = e4.nextE, e6 = e5.nextE;
          let p4 = e6.p1;
          let e10 = new Edge(p1, nd), e20 = new Edge(p2, nd),
            e30 = new Edge(p3, nd), e40 = new Edge(p4, nd);
          let tIndex = tris.indexOf(e.inT);
          tris.splice(tIndex, 1); // remove oldtriangle
          e.inT.removeEdges(edges);
          let t4Index = tris.indexOf(e4.inT);
          tris.splice(t4Index, 1); // remove old triangle
          e4.inT.removeEdges(edges);
          e5.asIndex();
          e2.asIndex();
          tris.push(new Triangle(edges, e2, e30, e20.makeSymm()));
          tris.push(new Triangle(edges, e3, e10, e30.makeSymm()));
          tris.push(new Triangle(edges, e5, e40, e10.makeSymm()));
          tris.push(new Triangle(edges, e6, e20, e40.makeSymm()));
          this.swapTest(e2, e3, e5, e6, e10, e20, e30, e40); // no varargs in pjs
        }
      }
    }

    expandHull(nd) {
      let e1, e2, e3 = null, enext, e = hullStart, comedge = null, lastbe = null;
      while (true) {
        enext = e.nextH;
        if (e.onSide(nd) == -1) // right side
        {
          if (lastbe != null) {
            e1 = e.makeSymm();
            e2 = new Edge(e.p1, nd);
            e3 = new Edge(nd, e.p2);
            if (comedge == null) {
              hullStart = lastbe;
              lastbe.setNextH(e2);
              lastbe = e2;
            } else
              comedge.rinkSymm(e2);
            comedge = e3;
            tris.push(new Triangle(edges, e1, e2, e3));
            this.swapTest(e);
          }
        } else {
          if (comedge != null) break;
          lastbe = e;
        }
        e = enext;
      }

      lastbe.setNextH(e3);
      e3.setNextH(e);
    }

    searchEdge(e, nd) {
      let f2, f3;
      let e0 = null;
      if ((f2 = e.nextE.onSide(nd)) == -1) {
        if (e.nextE.invE != null)
          return this.searchEdge(e.nextE.invE, nd);
        else {
          actE = e;
          return -1;
        }
      }
      if (f2 == 0)
        e0 = e.nextE;
      let ee = e.nextE;
      if ((f3 = ee.nextE.onSide(nd)) == -1) {
        if (ee.nextE.invE != null)
          return this.searchEdge(ee.nextE.invE, nd);
        else {
          actE = ee.nextE;
          return -1;
        }
      }
      if (f3 == 0)
        e0 = ee.nextE;
      if (e.onSide(nd) == 0)
        e0 = e;
      if (e0 != null) {
        actE = e0;
        if (e0.nextE.onSide(nd) == 0) {
          actE = e0.nextE;
          return 0;
        }
        if (e0.nextE.nextE.onSide(nd) == 0)
          return 0;
        return 1;
      }
      actE = ee;
      return 2;
    }

    swapTest(...e) {
      for (let i = 0; i < e.length; i++)
        this._swapTest(e[i]);
    }

    _swapTest(e) {
      let e21 = e.invE;
      if (e21 == null || e21.inT == null)
        return;
      let e12 = e.nextE, e13 = e12.nextE, e22 = e21.nextE, e23 = e22.nextE;
      if (e.inT.inCircle(e22.p2) || e21.inT.inCircle(e12.p2)) {
        e.updateEdge(e22.p2, e12.p2);
        e21.updateEdge(e12.p2, e22.p2);
        e.rinkSymm(e21);
        e13.inT.updateTriangle(e13, e22, e);
        e23.inT.updateTriangle(e23, e12, e21);
        e12.asIndex();
        e22.asIndex();
        this._swapTest(e12);
        this._swapTest(e22);
        this._swapTest(e13);
        this._swapTest(e23);
      }
    }

    nearest(x, y) {
      // locate a node nearest to (px,py)
      let dismin = 0.0, s;
      let nd = null;
      for (let i = 0; i < nodes.length; i++) {
        s = nodes[i].distance(x, y);
        if (s < dismin || nd == null) {
          dismin = s;
          nd = nodes[i];
        }
      }
      return nd;
    }
  }

  class Node {
    constructor(x, y) {
      this.x = x;
      this.y = y;
      this.anEdge = null; // an edge which start from this node
    }

    distance(px, py) {
      return dist(this.x, this.y, px, py);
    }
  }

class Edge {

  constructor(p1, p2) {
    this.p1 = null;
    this.p2 = null; // start and end point of the edge
    this.inT = null; // triangle containing this edge
    this.a = 0;
    this.b = 0;
    this.c = 0; // line equation parameters: aX+bY+c=0
    this.invE = null;
    this.nextE = null;
    this.nextH = null;
    this.updateEdge(p1, p2);
  }

  updateEdge(p1, p2) {
    this.p1 = p1;
    this.p2 = p2;
    this.setAbc();
    this.asIndex();
  }

  setNextE(e) {
    this.nextE = e;
  }

  setNextH(e) {
    this.nextH = e;
  }

  setTri(t) {
    this.inT = t;
  }

  setInvE(e) {
    this.invE = e;
  }

  makeSymm() {
    let e = new Edge(this.p2, this.p1);
    this.rinkSymm(e);
    return e;
  }

  rinkSymm(e) {
    this.invE = e;
    if (e != null)
      e.invE = this;
  }

  onSide(nd) {
    let s = this.a * nd.x + this.b * nd.y + this.c;
    if (s > 0.0)
      return 1;
    if (s < 0.0)
      return -1;
    return 0;
  }

  setAbc() // set parameters of a,b,c
  {
    this.a = this.p2.y - this.p1.y;
    this.b = this.p1.x - this.p2.x;
    this.c = this.p2.x * this.p1.y - this.p1.x * this.p2.y;
  }

  asIndex() {
    this.p1.anEdge = this;
  }

  mostLeft() {
    let ee, e = this;
    while ( (ee = e.nextE.nextE.invE) != null && ee != this)
      e = ee;
    return e.nextE.nextE;
  }

  mostRight() {
    let ee, e = this;
    while (e.invE != null && (ee = e.invE.nextE) != this)
      e = ee;
    return e;
  }
}

class Triangle {

  constructor(e1, e2, e3) {
    this.anEdge = null; // edge of this triangle
    this.c_cx = 0;
    this.c_cy = 0;
    this.c_r = 0;

    if (arguments.length === 4) {
      let edges = arguments[0];
      e1 = arguments[1];
      e2 = arguments[2];
      e3 = arguments[3];
      this.updateTriangle(e1, e2, e3);
      edges.push(e1);
      edges.push(e2);
      edges.push(e3);
    } else {
      this.updateTriangle(e1, e2, e3);
    }
  }

  updateTriangle(e1, e2, e3) {
    this.anEdge = e1;
    e1.setNextE(e2);
    e2.setNextE(e3);
    e3.setNextE(e1);
    e1.setTri(this);
    e2.setTri(this);
    e3.setTri(this);
    this.findCircle();
  }

  inCircle(nd) {
    return nd.distance(this.c_cx, this.c_cy) < this.c_r;
  }

  removeEdges(edges) {
    let e1Index = edges.indexOf(this.anEdge);
    edges.splice(e1Index, 1);
    let e2Index = edges.indexOf(this.anEdge.nextE);
    edges.splice(e2Index, 1);
    let e3Index = edges.indexOf(this.anEdge.nextE.nextE);
    edges.splice(e3Index, 1);
  }

  findCircle() {
    let x1 = this.anEdge.p1.x, y1 = this.anEdge.p1.y, x2 = this.anEdge.p2.x, y2 = this.anEdge.p2.y;
    let x3 = this.anEdge.nextE.p2.x, y3 = this.anEdge.nextE.p2.y;
    let a = (y2 - y3) * (x2 - x1) - (y2 - y1) * (x2 - x3);
    let a1 = (x1 + x2) * (x2 - x1) + (y2 - y1) * (y1 + y2);
    let a2 = (x2 + x3) * (x2 - x3) + (y2 - y3) * (y2 + y3);
    this.c_cx = (a1 * (y2 - y3) - a2 * (y2 - y1)) / a / 2;
    this.c_cy = (a2 * (x2 - x1) - a1 * (x2 - x3)) / a / 2;
    this.c_r = this.anEdge.p1.distance(this.c_cx, this.c_cy);
  }
}
</script>
