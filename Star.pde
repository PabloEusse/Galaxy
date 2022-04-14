public class Star { //<>//
  float posX, posY, mass, velX, velY;
  static final float constant=1;
  public Star(float a, float b, float c) {
    posX=a; 
    posY=b; 
    mass=c;
  }
  public void move() { //<>//
    posX+=velX;
    posY+=velY;
  }
}
