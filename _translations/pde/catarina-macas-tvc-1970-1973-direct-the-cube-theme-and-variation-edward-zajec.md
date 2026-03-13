---
title: "(TVC) 1970-1973"
translator: "Catarina Maçãs"
translator_url: "https://cdv.dei.uc.pt/authors/catarina-macas/"
slug: "catarina-macas-tvc-1970-1973-direct-the-cube-theme-and-variation-edward-zajec"
artwork_slug: "v1n2-the-cube-theme-and-variation"
category: "direct"
description: "Work made in the Generative Art course from the Master's degree in Design and Multimedia of the University of Coimbra, Portugal. Sketch made according top the rules in: https://digitalartmuseum.org/zajec/zajec70-73_002.html and to create digital artworks similar to: https://digitalartmuseum.org/zajec/1970-73-tvc.html"
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "The Cube Theme and Variation" by Edward Zajec
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2021 Catarina Maçãs - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

ArrayList<Modulo> grelha = new ArrayList<Modulo>();

float lado = 40;
int res = 20;

int valor_anterior;
int repetidos=0;


void settings(){
  size(round(res*lado), round(res*lado));
}

void setup() {
  
  //noLoop();
  definirGramatica();
  definirInicio();
}


void draw() {
  background(255);

  //desenha a grelha
  for (Modulo mod : grelha) {
    //mod.update_modulo();
    mod.desenha();
  }
}





void mousePressed() {
  
  
  grelha = new ArrayList<Modulo>();
  repetidos=0;
  definirInicio();
  
  /*
  int col_x = floor(mouseX/lado);
  int lin_y = floor(mouseY/lado);
  int aux2 = floor(random(0, 7));
  
  for(Modulo m : grelha){
    if(m.posicao == lin_y*res+col_x){
      m.update_modulo();
      break;
    }
  }*/
  
//  puzzle(grelha.set(lin_y*res+col_x, aux2), (float)col_x*lado, (float)lin_y*lado);
//  mudaModulos(col_x, lin_y);
  
}


void set_elemento_grelha(int posicao, int newValor){
  
  for(Modulo mod : grelha){
    if(mod.posicao == posicao){
      mod.valor = newValor;
      break;
    }
  }
}


int grelha_contem(int posic){
  int res = -1;
  
  for(Modulo m : grelha){
    if (m.posicao == posic){
      res = grelha.indexOf(m);
    }
  }
  
  return res;
  
}


ArrayList<Integer> apenas_comuns(Integer[] a, Integer[] b) {
  ArrayList<Integer> resultado = new ArrayList<Integer>();

  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < b.length; j++) {
      if (a[i] == b[j]) {
        resultado.add(b[j]);
      }
    }
  }
  return resultado;
}

boolean contem(Integer[] a, int b){
  boolean res=false;
  
  for(Integer m : a){
    if(m == b){
      res = true;
      break;
    }
  }
  
  return res;
}


ArrayList<Integer> removeElem(Integer[] a, Integer r) {
  ArrayList<Integer> result = new ArrayList<Integer>();

  for (Integer item : a) {
    if (!r.equals(item)) {
      result.add(item);
    }
  }
  return result;
}

ArrayList<Integer> apenas_iguais(ArrayList<Integer> f){
  
  ArrayList<Integer> res = new ArrayList<Integer>();
  
  res.add(f.get(0));
  
  for(Integer i : f){
    if(!res.contains(i)){
      res.add(i);
    }
  }
  
  return res;
  
}



ArrayList<Integer> toArrayList(Integer[] a) {
  ArrayList<Integer> result = new ArrayList<Integer>();

  for (Integer item : a) {
    result.add(item);
  }
  return result;
}


class Modulo{
  
  int posicao, valor;
  float pos_x, pos_y;
  boolean mudado;
  
  Modulo(int pos, float p_x, float p_y, int v){
    posicao = pos;
    pos_x = p_x;
    pos_y = p_y;
    valor = v;
    mudado = false;
  }
  
    
  void desenha(){
    switch(valor) {
    case 0: 
      noStroke();
      fill(255);
      rect(pos_x, pos_y, lado, lado);
      break;
    case 1: 
      stroke(0);
      for (float d=0; d<=0.99; d+=0.1) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x+lado, pos_x, d);
        line(pos_x, y_o, x_o, y_o);
      }
      noStroke();
      fill(0);
      triangle(pos_x+lado, pos_y, pos_x, pos_y+lado, pos_x+lado, pos_y+lado);
      break;
    case 2: 
      stroke(0);
      for (float d=0; d<=0.75; d+=0.25) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x, pos_x+lado, d);
        line(x_o, pos_y+lado, pos_x+lado, y_o);
      }
      noStroke();
      fill(0);
      triangle(pos_x, pos_y, pos_x, pos_y+lado, pos_x+lado, pos_y);
      break;
    case 3: 
      stroke(0);
      for (float d=0.25; d<=1; d+=0.25) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x, pos_x+lado, d);
        line(pos_x, y_o, x_o, pos_y);
      }
      for (float d=0.1; d<=1; d+=0.1) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x+lado, pos_x, d);
        line(x_o, y_o, pos_x+lado, y_o);
      }
  
      break;
    case 4: 
      fill(0);
      rect(pos_x, pos_y, lado, lado);
      break;
    case 5: 
      stroke(0);
      for (float d=0; d<=0.99; d+=0.1) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        line(pos_x, y_o, pos_x+lado, y_o);
      }
      break;
    case 6:
      stroke(0);
      for (float d=0.25; d<=1; d+=0.25) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x, pos_x+lado, d);
        line(pos_x, y_o, x_o, pos_y);
      }
      for (float d=0.25; d<=1; d+=0.25) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x, pos_x+lado, d);
        line(x_o, pos_y+lado, pos_x+lado, y_o);
      }
      break;
    case 7: 
      stroke(0);
      for (float d=0; d<=0.99; d+=0.1) {
        float y_o = lerp(pos_y, pos_y+lado, d);
        float x_o = lerp(pos_x+lado, pos_x, d);
        line(x_o, y_o, pos_x+lado, y_o);
      }
      noStroke();
      fill(0);
      triangle(pos_x, pos_y, pos_x+lado, pos_y, pos_x, pos_y+lado);
      break;
    }
  }
  
  void update_modulo(){
    //muda_valor_r();
    
    // ver o de cima se nao tiver ja sido mudado e se existir
    int cima = grelha_contem(posicao-res);
    if(cima > -1){
      if(!grelha.get(cima).mudado){
        println(posicao+" - o mod(C): "+cima+ " esta "+ grelha.get(cima).mudado);
        grelha.get(cima).muda_valor();
      }
    }
    
    // ver o da esquerda se nao tiver ja sido mudado e se existir
    int esquerda = grelha_contem(posicao-1);
    if(esquerda > -1){
      if(!grelha.get(esquerda).mudado){
        println(posicao+" - o mod(E): "+esquerda+ " esta "+ grelha.get(esquerda).mudado);
        //grelha.get(cima).muda_valor();
      }
    }
    
    // ver o de baixo se nao tiver ja sido mudado e se existir
    int baixo = grelha_contem(posicao+res);
    if(baixo > -1){
      if(!grelha.get(baixo).mudado){
        println(posicao+" - o mod(B): "+baixo+ " esta "+ grelha.get(baixo).mudado);
        //grelha.get(cima).muda_valor();
      }
    }
    
    // ver o da direita se nao tiver ja sido mudado e se existrir
    int direita = grelha_contem(posicao+1);
    if(direita > -1){
      if(!grelha.get(direita).mudado){
        println(posicao+" - o mod(D): "+direita+ " esta "+ grelha.get(direita).mudado);
        //grelha.get(cima).muda_valor();
      }
    }
  }
  
  void muda_valor(){
    
    ArrayList<Integer> possibilidades = new ArrayList<Integer>();
        
    //ver vizinho de cima e se existir acrescentar as possibilidades
    int cima = grelha_contem(posicao-res);
    if(cima > -1){
      int v_cima = grelha.get(cima).valor;
      for(Integer val : dados.get(v_cima).get(2)){
        possibilidades.add(val);
      }      
    }
    
    //ver vizinho da direita e se existir acrescentar as possibilidades
    int direita = grelha_contem(posicao+1);
    if(direita > -1){
      int v_direita = grelha.get(direita).valor;
      for(Integer val :dados.get(v_direita).get(3)){
        possibilidades.add(val);
      }
    }
    
    //ver vizinho de baixo e se existir acrescentar as possibilidades
    int baixo = grelha_contem(posicao+res);
    if(baixo > -1){
      int v_baixo = grelha.get(baixo).valor;
      for(Integer val :dados.get(v_baixo).get(0)){
        possibilidades.add(val);
      }
    }
    
    
    //ver vizinho da esquerda e se existir acrescentar as possibilidades
    int esquerda = grelha_contem(posicao-1);
    if(esquerda > -1){
      int v_esquerda = grelha.get(esquerda).valor;
      for(Integer val :dados.get(v_esquerda).get(1)){
        possibilidades.add(val);
      }
    }
    
    possibilidades = apenas_iguais(possibilidades);
    
    println(possibilidades);
    
  }
  
  
  
  
}




void definirInicio() {
  for (int linha=0; linha < res; linha++) {
    for (int col=0; col < res; col++) {

      int valor = 0;
      Integer[] possibilidades_ant, possibilidades_cima;      
      int posicao_actual = linha*res+col;
      ArrayList<Integer> possibilidades = new ArrayList<Integer>();

      //primeira linha (não tem vixinhos em cima)
      if (linha == 0) {
        if (col == 0) {
          //posicao(0,0)
          int aux = floor(random(0, 7));
          possibilidades.add(aux);
        }
        else {
          // ver quais as possibilidades consoante o anterior
          possibilidades = toArrayList(dados.get(grelha.get(posicao_actual-1).valor).get(1));
        }
      }

      // restantes linhas
      else if (linha != 0) {
        if (col == 0) { 
          possibilidades = toArrayList(dados.get(grelha.get(posicao_actual-res).valor).get(2));
        }
        else {

          possibilidades_ant = dados.get(grelha.get(posicao_actual-1).valor).get(1);
          possibilidades_cima = dados.get(grelha.get(posicao_actual-res).valor).get(2);
          possibilidades = apenas_comuns(possibilidades_ant, possibilidades_cima);
        }
      }

      if (possibilidades.size() == 0) {
        valor = 6;
      }
      else {
        valor = possibilidades.get(floor(random(0, possibilidades.size())));
      } 
      if (valor == valor_anterior) {
        repetidos++;
      }
      
      // correcçoes =X
      if (linha!=0) {
        if (grelha.get(posicao_actual-res+1).valor == 2 && valor == 0) {
          set_elemento_grelha(posicao_actual-res+1, 4);
        }
        if (grelha.get(posicao_actual-res+1).valor == 4 && valor == 6) {
          set_elemento_grelha(posicao_actual-res+1, 2);
        }
      }
      valor_anterior = valor;
      grelha.add( new Modulo(posicao_actual, col*lado, linha*lado, valor));
    }
  }
}


ArrayList<ArrayList<Integer[]>> dados = new ArrayList<ArrayList<Integer[]>>();


void definirGramatica() {
  
  // 0
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {0, 5, 3, 7});
  dados.get(dados.size()-1).add(new Integer[] {0, 2, 4, 7});
  dados.get(dados.size()-1).add(new Integer[] {1, 0, 5, 6});
  dados.get(dados.size()-1).add(new Integer[] {0, 6, 7});
  
  // 1
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {5, 6, 7});
  dados.get(dados.size()-1).add(new Integer[] {0, 4, 6, 7});
  dados.get(dados.size()-1).add(new Integer[] {4, 2, 5, 7});
  dados.get(dados.size()-1).add(new Integer[] {5, 7});
  
  // 2
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {1, 4});
  dados.get(dados.size()-1).add(new Integer[] {0, 6});
  dados.get(dados.size()-1).add(new Integer[] {1, 6});
  dados.get(dados.size()-1).add(new Integer[] {0, 4});
  
  // 3
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {0, 6});
  dados.get(dados.size()-1).add(new Integer[] {5});
  dados.get(dados.size()-1).add(new Integer[] {0,5});
  dados.get(dados.size()-1).add(new Integer[] {6});
  
  // 4
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {1, 4});
  dados.get(dados.size()-1).add(new Integer[] {0, 2, 4, 6, 7});
  dados.get(dados.size()-1).add(new Integer[] {1, 2, 4, 7});
  dados.get(dados.size()-1).add(new Integer[] {0, 1, 4});
  
  // 5
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {5, 6, 7});
  dados.get(dados.size()-1).add(new Integer[] {1, 5});
  dados.get(dados.size()-1).add(new Integer[] {1, 0, 5});
  dados.get(dados.size()-1).add(new Integer[] {3, 5, 7});
  
  // 6
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {0, 2, 6});
  dados.get(dados.size()-1).add(new Integer[] {3, 6, 0});
  dados.get(dados.size()-1).add(new Integer[] {1, 3, 5, 6});
  dados.get(dados.size()-1).add(new Integer[] {2, 4, 6});
  
  // 7
  dados.add(new ArrayList<Integer[]>());
  dados.get(dados.size()-1).add(new Integer[] {0, 4});
  dados.get(dados.size()-1).add(new Integer[] {0, 5, 1});
  dados.get(dados.size()-1).add(new Integer[] {0, 5, 1});
  dados.get(dados.size()-1).add(new Integer[] {0, 4, 1});
  
}
