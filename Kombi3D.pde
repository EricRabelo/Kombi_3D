import processing.sound.*;
SoundFile file;
PImage placa;
float PosX = 151.46713;
float PosY = 50.111523;
float zoom=700;
float velocidade=PI/(20*width);
int chaveAudio = 0, chaveLimparParabrisa = 0, chaveRetrairRetrovisores = 0, chaveAcenderFarois = 0, chavePiscaEsquerdo = 0, chavePiscaDireito = 0, chavePiscaAlerta = 0;
int rotacaoLimpadores = 0, limpadoresDescendo = 0, tempoLimpadores = 0, rotacaoRetrovisores = 0, retrovisoresRetraidos = 0;

class coord
{
  float x, y, z;
  coord(float a, float b, float c)
  {
    x = a;
    y = b;
    z = c;
  }
}

void setup(){
  size(1024,768,P3D);
  placa = loadImage("Placa.jpg");

  file = new SoundFile(this, "partida.mp3");
  file.amp(1);
}
void keyPressed(){
  if(key == 'L' || key == 'l')//ativa / desativa o movimento dos limpadores de parabrisas
    chaveLimparParabrisa = (chaveLimparParabrisa == 0) ? 1 : 0;
  if(key == 'R' || key == 'r')//recolhe / extende os retrovisores
    chaveRetrairRetrovisores = (chaveRetrairRetrovisores == 0)? 1 : 0;
  if(key == 'F' || key == 'f')//acende / apaga os faróis
    chaveAcenderFarois = (chaveAcenderFarois == 0)? 1 : 0;
  if(key == '4')//ativa o pisca esquerdo
  {
    chavePiscaEsquerdo = (chavePiscaEsquerdo == 0)? 1 : 0;
    chavePiscaDireito = 0;//desativa o direito
  }
  if(key == '6')//ativa o pisca direito
  {
    chavePiscaDireito = (chavePiscaDireito == 0)? 1 : 0;
    chavePiscaEsquerdo = 0;//desativa o esquerdo
  }
  if(key == 'A' || key == 'a')//ativa o pisca-alerta
  {
    chavePiscaAlerta = (chavePiscaAlerta == 0)? 1 : 0;
    chavePiscaEsquerdo = chavePiscaDireito = 0;
  }
  if(key == 'M' || key == 'm')//dar partida no motor/desativar chaveAudio
  {
    chaveAudio = (chaveAudio == 0) ? 1 : 0;
    if(chaveAudio == 1)
      file.play();
    else
      file.stop();
  }
}
void mouseWheel(MouseEvent event){
  zoom+=event.getCount()*50;
}
void draw(){
  frameRate(30);
  ambientLight(140, 140, 140);
  pointLight(115, 115, 115, mouseX, mouseY, 0);
  background(135);
  translate(512,150,-zoom);
  if (mousePressed){
     PosX += (pmouseX-mouseX)*velocidade;
     PosY += (pmouseY-mouseY)*velocidade;
     rotateX(PosY);
     rotateY(-PosX);
  }else{
    rotateX(PosY);
    rotateY(-PosX);
  }
  criarLataria();
  criarRetrovisores();
  criarRodas();
  criarFarois();
  criarDetalhesFrente();
  criarLimpadorParabrisa();
  criarDetalhesCosta();
  //saveFrame("videoDemonstracao/###");
}
void criarLimpadorParabrisa()
{
  //girar limpadores
  if(chaveLimparParabrisa == 1 && tempoLimpadores == 0)
  {
    if(limpadoresDescendo == 0)//parabrisa descendo
     rotacaoLimpadores++;
    else//parabrisa subindo
      rotacaoLimpadores--;
    if(rotacaoLimpadores == 15 || rotacaoLimpadores == 0)
      limpadoresDescendo = (limpadoresDescendo == 0)? 1 : 0;//troca a direção do movimento
    if(rotacaoLimpadores == 0)
      tempoLimpadores = 10;//timer
  }
  else if(chaveLimparParabrisa == 1)
    tempoLimpadores--;
  else 
    tempoLimpadores = 0;
  
  //Limpador Direito
  fill(40,40,40);
  translate(85, 205, 351);
 
  //girando limpador direito
  rotateZ(-1*rotacaoLimpadores*0.145);
  
  sphere(4);//base do limpador de parabrisa direito
  translate(0,0,2);
  float Xfinal, Yfinal, Zfinal;
  Xfinal = 60;
  Yfinal = -30;
  Zfinal = -(0.125*75);
  strokeWeight(2);
  stroke(0);
  line(0, 0, 0, Xfinal, Yfinal, Zfinal);
  strokeWeight(1);
  translate(Xfinal, Yfinal, Zfinal);
  box(60,4,2);
  translate(-Xfinal, -Yfinal, -Zfinal);
  
  //desfazendo rotação usada pro limpador
  rotateZ(rotacaoLimpadores*0.145);
  
  //Limpador Esquerdo
  translate(-170, 0, -2);
  
  //girando limpador esquerdo
  rotateZ(-1*rotacaoLimpadores*0.145);
  
  sphere(4);//base do limpador de parabrisa direito
  translate(0,0,2);
  Xfinal = 60;
  Yfinal = -30;
  Zfinal = -(0.125*75);
  strokeWeight(2);
  stroke(0);
  line(0, 0, 0, Xfinal, Yfinal, Zfinal);
  strokeWeight(1);
  translate(Xfinal, Yfinal, Zfinal);
  box(60,4,2);
  translate(-Xfinal, -Yfinal, -Zfinal);
  
  //desfazendo rotação usada pro limpador
  rotateZ(rotacaoLimpadores*0.145);
  
  //Limpador traseiro
  translate(85, 0, -704);
  
  //girando limpador traseiro
  rotateZ(-1*rotacaoLimpadores*0.145);
  
  sphere(4);//base do limpador de parabrisa traseiro
  translate(0,0,-2);
  Xfinal = 60;
  Yfinal = -30;
  Zfinal = (0.125*75);
  strokeWeight(2);
  stroke(0);
  line(0, 0, 0, Xfinal, Yfinal, Zfinal);
  strokeWeight(1);
  translate(Xfinal, Yfinal, Zfinal);
  box(60,4,2);
  translate(-Xfinal, -Yfinal, -Zfinal);
  
  //desfazendo rotação usada pro limpador
  rotateZ(rotacaoLimpadores*0.145);
  
  translate(0, -205, 353);
  noStroke();
}

void criarDetalhesFrente()
{
  noStroke();
  //Adicionando radiador da frente da kombi
  translate(0,410,352);
  fill(40,40,40);
  box(170,150,4);
  translate(0,-410,-352); //voltando ao ponto (500, 500, 0)

  //Adicionando retangulo de cima da kombi
  translate(0,300,352);
  fill(40,40,40);
  box(320,40,4);
  
  //definindo Cor do pisca alerta direito
  if((chavePiscaDireito == 0 && chavePiscaAlerta == 0) || frameCount % 3 == 0)
    fill(#FF7200,100); //Cor Laranja com fator de transparência
  else
    fill(#FF7200); //Cor Laranja sem fator de transparência
  
  //Adicionando pisca alerta Direito
  translate(130,0,4);
  box(50,30,2);
  
  //definindo Cor do pisca alerta esquerdo
  if((chavePiscaEsquerdo == 0 && chavePiscaAlerta == 0) || frameCount % 3 == 0)
    fill(#FF7200,100); //Cor Laranja com fator de transparência
  else
    fill(#FF7200); //Cor Laranja sem fator de transparência
  
  //Adicionando pisca alerta Esquerdo
  translate(-260,0,0);
  box(50,30,2);
  //voltando ao ponto (500, 500, 0)
  translate(130,-300,-356);
}

void criarDetalhesCosta()
{
  fill(40, 40, 40);
  translate(-150, 400, -350);
  box(30, 90, 2);
  fill(100, 10, 10);
  box(28, 28, 4);//vermelho central esq
  translate(0, -30, 0);
  //definindo Cor do pisca alerta esquerdo traseiro
  if((chavePiscaEsquerdo == 0 && chavePiscaAlerta == 0) || frameCount % 3 == 0)
    fill(#FF7200,100); //Cor Laranja com fator de transparência
  else
    fill(#FF7200); //Cor Laranja sem fator de transparência
  box(28, 28, 4);//amarelo superior esq
  translate(0, 60, 0);
  if(chaveAcenderFarois == 1)
    fill(255, 255, 255);
  else
    fill(255, 255, 255, 100);
  box(28, 28, 4);//branco inferior esq
  
  fill(40, 40, 40);
  translate(300, -30, 0);
  box(30, 90, 2);
  fill(100, 10, 10);
  box(28, 28, 4);//vermelho central dir
  translate(0, -30, 0);
  //definindo Cor do pisca alerta direito traseiro
  if((chavePiscaDireito == 0 && chavePiscaAlerta == 0) || frameCount % 3 == 0)
    fill(#FF7200,100); //Cor Laranja com fator de transparência
  else
    fill(#FF7200); //Cor Laranja sem fator de transparência
  box(28, 28, 4);//amarelo superior dir
  translate(0, 60, 0);
  if(chaveAcenderFarois == 1)
    fill(255, 255, 255);
  else
    fill(255, 255, 255, 100);
  box(28, 28, 4);//branco inferior dir
  
  translate(-150, -430, 350);
}

void criarFarois()
{
  translate(150, 400, 350);
  int raio = 30;
  //acender/apagar farois
  strokeWeight(0.5);
  if(chaveAcenderFarois == 1)
  {
    fill(#ff7200);
    stroke(180, 180, 180, 90);
  }
  else
  {
    fill(#ff7200, 100);
    stroke(180, 180, 180);
  }
  beginShape();//Desenha o farol esquerdo
  for(float j = 0; j < PI; j += PI/90)
    for(float i = 0; i < 2*PI; i += PI/45)
      vertex(raio*cos(j)*sin(i),raio*cos(j)*cos(i), raio*sin(j)/3);
  endShape(CLOSE);
  translate(-300, 0, 0);
  beginShape();//Desenha o farol esquerdo
  for(float j = 0; j < PI; j += PI/90)
    for(float i = 0; i < 2*PI; i += PI/45)
      vertex(raio*cos(j)*sin(i),raio*cos(j)*cos(i), raio*sin(j)/3);
  endShape(CLOSE);
  translate(150, -400, -350);
  strokeWeight(1);
}

void criarRodas()
{
  float raio = 70;
  float largura = 50;
  fill(40,40,40);
  stroke(40,40,40);
  for(float i = 0; i < largura; i+=1)
  {
    beginShape();//roda dianteira esquerda
    for(float j = 0; j < PI*2; j+= PI/180)
      vertex(160+i, 500 + raio*sin(j), 250 + raio*cos(j));
    endShape(CLOSE);
  }
  for(float i = 0; i < largura; i+=1)
  {
    beginShape();//roda dianteira direita
    for(float j = 0; j < PI*2; j+= PI/180)
      vertex(-160-i, 500 + raio*sin(j), 250 + raio*cos(j));
    endShape(CLOSE);
  }
  for(float i = 0; i < largura; i+=1)
  {
    beginShape();//roda traseira esquerda
    for(float j = 0; j < PI*2; j+= PI/180)
      vertex(-160-i, 500 + raio*sin(j), -250 + raio*cos(j));
    endShape(CLOSE);
  }
  for(float i = 0; i < largura; i+=1)
  {
    beginShape();//roda traseira direita
    for(float j = 0; j < PI*2; j+= PI/180)
      vertex(160+i, 500 + raio*sin(j), -250 + raio*cos(j));
    endShape(CLOSE);
  }
  for(float i = 0; i < largura; i+=1)
  {
    beginShape();//strepe traseiro
    for(float j = 0; j < PI*2; j+= PI/180)
      vertex(raio*sin(j), 380 + raio*cos(j), -350 - i);
    endShape(CLOSE);
  }
}

void criarRetrovisores()
{
  int raio = 20;
  float x, y, z, Xfinal, Yfinal, Zfinal;
  coord aux;
  fill(40,40,40);
  stroke(40,40,40);
  
  //retrair Retrovisor direito
  if(chaveRetrairRetrovisores == 1)
  {
    if(retrovisoresRetraidos == 1)
        rotacaoRetrovisores--;
    else
        rotacaoRetrovisores++;
    if(rotacaoRetrovisores > 4 || rotacaoRetrovisores < 0)
    {
        retrovisoresRetraidos = (retrovisoresRetraidos == 0)? 1 : 0;
        chaveRetrairRetrovisores = 0;
    }
  }
  
  //retrovisor direito
  translate(192, 200, 340);
  
  //rotacionando
  rotateY(rotacaoRetrovisores*0.145);
  
  //carcaça direita
  translate(28, -25, -17);
  
  //rotacionando dnv
  rotateY(rotacaoRetrovisores*0.0725);
  
  box(25, 50, 5);
  
  //espelho direito
  translate(0, 0, -3);
  fill(255, 255, 255, 90);
  box(23, 48, 1);
  translate(0, 0, 3);
  
  //desrotacionando
  rotateY(-1*rotacaoRetrovisores*0.0725);
  
  translate(-28, 25, 17);
  
  //haste direita
  fill(40,40,40);
  Xfinal = 28;
  Yfinal = -25;
  Zfinal = -17;
  strokeWeight(3);
  line(0, 0, 0, Xfinal, Yfinal, Zfinal);
  
  //desrotacionando
  rotateY(-1*rotacaoRetrovisores*0.145);
  
  //retrovisor esquerdo
  translate(-192 * 2, 0, 0);
  
  //rotacionando
  rotateY(-1*rotacaoRetrovisores*0.145);
  strokeWeight(1);
    
  //carcaça esquerda
  translate(-28, -25, -17);
  
  //rotacionando dnv
  rotateY(-1*rotacaoRetrovisores*0.0725);
  box(25, 50, 5);
  
  //espelho esquerdo
  translate(0, 0, -3);
  fill(255, 255, 255, 90);
  box(23, 48, 1);
  translate(0, 0, 3);
    
  //desrotacionando
  rotateY(rotacaoRetrovisores*0.0725);
  
  //haste esquerda
  translate(28, 25, 17);
  Xfinal = -28;
  strokeWeight(3);
  line(0, 0, 0, Xfinal, Yfinal, Zfinal);
  strokeWeight(1);
  
  //desrotacionando
  rotateY(rotacaoRetrovisores*0.145);
  
  //retornando à origem
  translate(192, -200, -340);
  noStroke();
}

void criarLataria(){
  //parte 1
  noStroke();
  float espessura = 10;
  for (int i = 0; i < 50; i = i+1) {
    if(i>=40){
      fill(255);
    }else{
      fill(0,127,255);
    }
    box(291.3 + 17*log(i), 1, 532.6 + 35*log(i));
    translate(0,1,0);
  }
  for (int i = 0; i < 150; i = i+1) {
    fill(255,255,255, 100);
    box(350+(0.25*i), 1, 650+(0.25*i));
    fill(255);
    translate(175+(0.125*i), 0, 325 + (0.125*i));
    box(espessura, 1, espessura);// aste dianteira direita
    translate(-175-(0.125*i), 0, -325 - (0.125*i));

    translate(-175-(0.125*i), 0, -325 - (0.125*i));
    box(espessura, 1, espessura);//aste traseira esquerda
    translate(175+(0.125*i), 0, 325 + (0.125*i));

    translate(-175-(0.125*i), 0, 325 + (0.125*i));
    box(espessura, 1, espessura);//aste dianteira esquerda
    translate(175+(0.125*i), 0, -325 - (0.125*i));
    
    translate(175+(0.125*i), 0, -325 - (0.125*i));
    box(espessura, 1, espessura);//aste traseira direita
    translate(-175-(0.125*i), 0, 325 + (0.125*i));
    
    translate(175+(0.125*i), 0, 110);
    box(espessura, 1, espessura);// aste mediana frontal direita
    translate(-175-(0.125*i), 0, -110);
    
    translate(175+(0.125*i), 0, -110);
    box(espessura, 1, espessura);// aste mediana traseira direita
    translate(-175-(0.125*i), 0, 110);
    
    translate(-175-(0.125*i), 0, 110);
    box(espessura, 1, espessura);// aste mediana frontal esquerda
    translate(+175+(0.125*i), 0, -110);
    
    translate(-175-(0.125*i), 0, -110);
    box(espessura, 1, espessura);// aste mediana traseira esquerda
    translate(+175+(0.125*i), 0, 110);
    translate(0,1,0);
  }
  for (int i = 0; i < 300; i = i+1) {
    if (i<=10){
      fill(255);
      box(400, 1, 700);
    }else if(i>=280){
      fill(255);
      box(410, 1, 710);
    }else{
      fill(0,127,255);
      box(400, 1, 700);
    }
    translate(0,1,0);
  }
  translate(-60, -25, 360);
  image(placa, 0, 0, 120, 39);
  translate(120, 0, -720);
  rotateY(PI);
  image(placa, 0, 0, 120, 39);
  rotateY(PI);
  translate(-60, -475, 360);//voltando ao ponto (500, 500, 0)
}
