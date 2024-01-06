import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;


Ground g;
Sphere s;
float constante = 0;
float moveX = 0;
float moveZ = 0;
float moveY = 0;

float verticaleTranslate = 0;
float horizontaleTranslate = 0;
float depthTranslate = 0;
float rotationX = 0;
float rotationY = 0;
float constX = 0;
float constY = 0;

Point gravity = new Point(0,-1,0);

boolean keyW, keyA, keyS, keyD, keySpace, keyCtrl, keyY, keyX;


void setup(){
    size(1200,800,P3D);
    noStroke();
    g = new Ground(40,10);
    gravity = new Point(0,-0.001,0);
    //x y z r gravity k
    //int int int int point float
    s = new Sphere(200,-500,200,10, gravity, 0.90);
    
}



void draw(){
    lights();
    background(0);
    pushMatrix();

    float cameraY = height/2.0;
    float fov = mouseX/float(width)*PI/2;
    float cameraZ = cameraY / tan(fov /2.0);
    float aspect = float(width)/float(height);
    //côté du cube
    float c = 500;
    //couleur côté cube
    perspective(fov,aspect,cameraZ/10.0,cameraZ*10.0);
    //translation au centre de l'écran
    translate(550+moveX, 200+moveY, -500+moveZ);

    //rotation input utilisateur
    rotateX(-PI/6);
    rotateY(PI/3 + mouseY/float(height)*PI);
    
    int nbCote = 40;

    g.drawSurface();
    s.display();
    s.move();
    s.checkWallCollision();
    s.checkGroundCollision(g);

    updateMovement();
    popMatrix();
}





void drawSquare(Point p1, Point p2, Point p3, Point p4){
    beginShape();
        fill(255,255,255);
        vertex(p1.x,p1.y,p1.z);
        vertex(p2.x,p2.y,p2.z);
        vertex(p3.x,p3.y,p3.z);
        vertex(p4.x,p4.y,p4.z);
    endShape(CLOSE);
}

void keyPressed() {
    if(key == ' ' && keyCode == SHIFT){
    moveX = moveX+20;
    }
    if (key == 'q' || key == 'Q'){    
    moveX = moveX+20;
    }
    if (key == 'd' || key == 'D'){
    moveX = moveX-20;
    }
    if (key == 'a' || key == 'A'){
    moveZ = moveZ+20;
    }
    if (key == 'e' || key == 'E'){
    moveZ = moveZ-20;
    }
    if (key == 'z' || key == 'Z'){
    moveY = moveY+20;
    }
    if (key == 's' || key == 'S'){
    moveY = moveY-20;
    }
    if(key == ' '){
        println("test");
    }
    println("Key: " + key + " | Code: " + keyCode);

}


void updateMovement() {
  if (keySpace) {
    verticaleTranslate += 10;
  }
  if (keyCtrl) {
    verticaleTranslate -= 10;
  }
  if (keyW) {
    depthTranslate += 10;
  }
  if (keyA) {
    horizontaleTranslate += 10;
  }
  if (keyD) {
    horizontaleTranslate -= 10;
  }
  if (keyS) {
    depthTranslate -= 10;
  }
  if (keyY) {
    constY += 0.01;
    rotationY = constY * PI;
  }
    if (keyX) {
    constX += 0.01;
    rotationX = constX * PI;
  }
}

