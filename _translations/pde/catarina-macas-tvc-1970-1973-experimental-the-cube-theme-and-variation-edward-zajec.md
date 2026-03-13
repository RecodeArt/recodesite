---
title: "(TVC) 1970-1973"
translator: "Catarina Maçãs"
translator_url: "https://cdv.dei.uc.pt/authors/catarina-macas/"
slug: "catarina-macas-tvc-1970-1973-experimental-the-cube-theme-and-variation-edward-zajec"
artwork_slug: "v1n2-the-cube-theme-and-variation"
category: "experimental"
description: "Work made in the Generative Art course from the Master's degree in Design and Multimedia of the University of Coimbra, Portugal. Sketch made according top the rules in: https://digitalartmuseum.org/zajec/zajec70-73_002.html and to create digital artworks similar to: https://digitalartmuseum.org/zajec/1970-73-tvc.html"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "The Cube Theme and Variation" by Edward Zajec
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2021 Catarina Maçãs - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

let grelha = [];

let lado = 40;
let res = 20;

let valor_anterior;
let repetidos=0;

let dados = [];


function setup(){
  createCanvas(res*lado, res*lado);

  //noLoop();
  definirGramatica();
  definirInicio();
}


function draw() {
  background(255);

  //desenha a grelha
  for( let mod of grelha){
    //mod.update_modulo();
    mod.desenha();
  }
}





function mousePressed() {
  
  
  grelha = [];
  repetidos=0;
  definirInicio();
  
  
}


function set_elemento_grelha(posicao, newValor){
  
  for (let mod of grelha) {
  if(mod.posicao == posicao){
      mod.valor = newValor;
      break;
    }
}

}


function grelha_contem(posic){
  let res = -1;
  
  grelha.foreach(function(m){
    if (m.posicao == posic){
      res = grelha.indexOf(m);
    }
  });
  
  return res;
  
}


function apenas_comuns(a, b) {
  let resultado = [];

  for (let i = 0; i < a.length; i++) {
    for (let j = 0; j < b.length; j++) {
      if (a[i] == b[j]) {
        resultado.push(b[j]);
      }
    }
  }
  return resultado;
}

function contem(a, b){
  let res=false;
  
  for(let m of a){
    if(m == b){
      res = true;
      break;
    }
  }
  
  return res;
}


function removeElem(a, r) {
  let result = [];

  a.foreach(function(item) {
    if (!r.equals(item)) {
      result.push(item);
    }
  });
  return result;
}

function apenas_iguais(f){
  
  let res = [];
  
  res.push(f[0]);
  
  for(let i of f){
    if(!res.contains(i)){
      res.push(i);
    }
  }
  
  return res;
  
}



function toArrayList(a) {
  let result = [];

  for (let item of a) {
    result.push(item);
  }
  return result;
}


// ----------------

class Modulo{

  
  constructor( pos,  p_x,  p_y,  v){
    this.posicao = pos;
    this.pos_x = p_x;
    this.pos_y = p_y;
    this.valor = v;
    this.mudado = false;
  }
  
    
  desenha(){
    switch(this.valor) {
    case 0: 
      noStroke();
      fill(255);
      rect(this.pos_x, this.pos_y, lado, lado);
      break;
    case 1: 
      stroke(0);
      for (let d=0; d<=0.99; d+=0.1) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x+lado, this.pos_x, d);
        line(this.pos_x, y_o, x_o, y_o);
      }
      noStroke();
      fill(0);
      triangle(this.pos_x+lado, this.pos_y, this.pos_x, this.pos_y+lado, this.pos_x+lado, this.pos_y+lado);
      break;
    case 2: 
      stroke(0);
      for (let d=0; d<=0.75; d+=0.25) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x, this.pos_x+lado, d);
        line(x_o, this.pos_y+lado, this.pos_x+lado, y_o);
      }
      noStroke();
      fill(0);
      triangle(this.pos_x, this.pos_y, this.pos_x, this.pos_y+lado, this.pos_x+lado, this.pos_y);
      break;
    case 3: 
      stroke(0);
      for (let d=0.25; d<=1; d+=0.25) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x, this.pos_x+lado, d);
        line(this.pos_x, y_o, x_o, this.pos_y);
      }
      for (let d=0.1; d<=1; d+=0.1) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x+lado, this.pos_x, d);
        line(x_o, y_o, this.pos_x+lado, y_o);
      }
  
      break;
    case 4: 
      fill(0);
      rect(this.pos_x, this.pos_y, lado, lado);
      break;
    case 5: 
      stroke(0);
      for (let d=0; d<=0.99; d+=0.1) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        line(this.pos_x, y_o, this.pos_x+lado, y_o);
      }
      break;
    case 6:
      stroke(0);
      for (let d=0.25; d<=1; d+=0.25) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x, this.pos_x+lado, d);
        line(this.pos_x, y_o, x_o, this.pos_y);
      }
      for (let d=0.25; d<=1; d+=0.25) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x, this.pos_x+lado, d);
        line(x_o, this.pos_y+lado, this.pos_x+lado, y_o);
      }
      break;
    case 7: 
      stroke(0);
      for (let d=0; d<=0.99; d+=0.1) {
        let y_o = lerp(this.pos_y, this.pos_y+lado, d);
        let x_o = lerp(this.pos_x+lado, this.pos_x, d);
        line(x_o, y_o, this.pos_x+lado, y_o);
      }
      noStroke();
      fill(0);
      triangle(this.pos_x, this.pos_y, this.pos_x+lado, this.pos_y, this.pos_x, this.pos_y+lado);
      break;
    }
  }
  
  update_modulo(){
    //muda_valor_r();
    
    // ver o de cima se nao tiver ja sido mudado e se existir
    let cima = grelha_contem(posicao-res);
    if(cima > -1){
      if(!grelha[cima].mudado){
        println(posicao+" - o mod(C): "+cima+ " esta "+ grelha[cima].mudado);
        grelha[cima].muda_valor();
      }
    }
    
    // ver o da esquerda se nao tiver ja sido mudado e se existir
    let esquerda = grelha_contem(posicao-1);
    if(esquerda > -1){
      if(!grelha[esquerda].mudado){
        println(posicao+" - o mod(E): "+esquerda+ " esta "+ grelha[esquerda].mudado);
      }
    }
    
    // ver o de baixo se nao tiver ja sido mudado e se existir
    let baixo = grelha_contem(posicao+res);
    if(baixo > -1){
      if(!grelha[baixo].mudado){
        println(posicao+" - o mod(B): "+baixo+ " esta "+ grelha[baixo].mudado);
      }
    }
    
    // ver o da direita se nao tiver ja sido mudado e se existrir
    let direita = grelha_contem(posicao+1);
    if(direita > -1){
      if(!grelha[direita].mudado){
        println(posicao+" - o mod(D): "+direita+ " esta "+ grelha[direita].mudado);
      }
    }
  }
  
  muda_valor(){
    
    let possibilidades = [];
        
    //ver vizinho de cima e se existir acrescentar as possibilidades
    let cima = grelha_contem(posicao-res);
    if(cima > -1){
      let v_cima = grelha[cima].valor;
      for(let val of dados[v_cima][2]){
        possibilidades.push(val);
      }      
    }
    
    //ver vizinho da direita e se existir acrescentar as possibilidades
    let direita = grelha_contem(posicao+1);
    if(direita > -1){
      let v_direita = grelha[direita].valor;
      for(let val of dados[v_direita][3]){
        possibilidades.push(val);
      }
    }
    
    //ver vizinho de baixo e se existir acrescentar as possibilidades
    let baixo = grelha_contem(posicao+res);
    if(baixo > -1){
      let v_baixo = grelha[baixo].valor;
      for(let val of dados[v_baixo][0]){
        possibilidades.push(val);
      }
    }
    
    
    //ver vizinho da esquerda e se existir acrescentar as possibilidades
    let esquerda = grelha_contem(posicao-1);
    if(esquerda > -1){
      let v_esquerda = grelha[esquerda].valor;
      for(let val of dados[v_esquerda][1]){
        possibilidades.push(val);
      }
    }
    
    possibilidades = apenas_iguais(possibilidades);
    
    println(possibilidades);
    
  }
  
}

function definirInicio() {
  for (let linha=0; linha < res; linha++) {
    for (let col=0; col < res; col++) {

      let valor = 0;
      let possibilidades_ant, possibilidades_cima;      
      let posicao_actual = linha*res+col;
      let possibilidades = [];

      //primeira linha (não tem vixinhos em cima)
      if (linha == 0) {
        if (col == 0) {
          //posicao(0,0)
          let aux = floor(random(0, 7));
          possibilidades.push(aux);
        }
        else {
          // ver quais as possibilidades consoante o anterior
          possibilidades = toArrayList(dados[grelha[posicao_actual-1].valor][1]);
        }
      }

      // restantes linhas
      else if (linha != 0) {
        if (col == 0) { 
          possibilidades = toArrayList(dados[grelha[posicao_actual-res].valor][2]);
        }
        else {

          possibilidades_ant = dados[grelha[posicao_actual-1].valor][1];
          possibilidades_cima = dados[grelha[posicao_actual-res].valor][2];
          possibilidades = apenas_comuns(possibilidades_ant, possibilidades_cima);
        }
      }

      if (possibilidades.length == 0) {
        valor = 6;
      }
      else {
        valor = possibilidades[floor(random(0, possibilidades.length))];
      } 
      if (valor == valor_anterior) {
        repetidos++;
      }
      
      // correcçoes =X
      if (linha!=0) {
        if (grelha[posicao_actual-res+1].valor == 2 && valor == 0) {
          set_elemento_grelha(posicao_actual-res+1, 4);
        }
        if (grelha[posicao_actual-res+1].valor == 4 && valor == 6) {
          set_elemento_grelha(posicao_actual-res+1, 2);
        }
      }
      valor_anterior = valor;
      grelha.push( new Modulo(posicao_actual, col*lado, linha*lado, valor));
    }
  }
}


function definirGramatica() {
  
  // 0
  
  let zero = [[0, 5, 3, 7], [0, 2, 4, 7],[1, 0, 5, 6],[0, 6, 7]];
  dados.push(zero);
  
  // 1
   let one = [[5, 6, 7], [0, 4, 6, 7],[4, 2, 5, 7],[5, 7]];
  dados.push(one);
  
  // 2
  let two = [[1, 4],[0, 6],[1, 6],[0, 4]];
  dados.push(two);
  
  // 3
  let three = [[0, 6],[5],[0,5],[6]];
  dados.push(three);
  
  // 4
  let four = [[1, 4],[0, 2, 4, 6, 7],[1, 2, 4, 7],[0, 1, 4]];
  dados.push(three);
  
  // 5
let five = [[5, 6, 7],[1, 5],[1, 0, 5],[3, 5, 7]];
  dados.push(five);
  
  // 6
let six = [[0, 2, 6],[3, 6, 0],[1, 3, 5, 6],[2, 4, 6]];
  dados.push(six);

  
  // 7
let seven = [[0, 4],[0, 5, 1],[0, 5, 1],[0, 4, 1]];
  dados.push(seven);
  
}
