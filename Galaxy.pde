public class Galaxy { //<>// //<>//
  Star[] stars;
  final float gConstant; //gravitational constant
  public Galaxy(int numberOfStars, float gConstant) {
    stars = new Star[numberOfStars];
    this.gConstant = gConstant;
  }

  public void drawGalaxy() {
    for (Star x : stars) {
      float size = sqrt(x.mass / 3);
      ellipse(x.posX, x.posY, size, size);
    }
  }

  public void randomSetUp(float width1, float height1) { //creates a galaxy with a random set stationary stars
    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star((float)(Math.random()*width1), (float)(Math.random()*height1), (float)Math.random()*10);
    }
  }
  /*
  creates stars within galaxyDiameter/2 distance from the center of the galaxy.
   then computes the angular velocity necessary for each star to mantain a circular orbit around the black hole according to the centrifugal force equation
   */
  public void setUp(float holeMass, int posX, int posY, int galaxyDiameter, int starsMaxMass) { //create a galaxy with a set of circular orbiting stars
    stars[0] = new Star(posX, posY, holeMass); // instantiates a massive star at the star representing the black hole
    for (int i=1; i<stars.length; i++) { 
      stars[i]=new Star((float)Math.random()*galaxyDiameter+stars[0].posX-galaxyDiameter/2, (float)Math.random()*galaxyDiameter+stars[0].posY-galaxyDiameter/2, (float)Math.random()*starsMaxMass);
      float r=sqrt((stars[0].posX-stars[i].posX)*(stars[0].posX-stars[i].posX)+(stars[0].posY-stars[i].posY)*(stars[0].posY-stars[i].posY));
      float angulo = acos((stars[0].posX-stars[i].posX)/r);
      if (stars[i].posY>stars[0].posY) {
        angulo*=-1;
      }
      angulo-=PI/2;
      float vel=sqrt((stars[0].mass*gConstant)/r);
      stars[i].velY = sin(angulo)*vel;
      stars[i].velX = cos(angulo)*vel;
      stars[i].velX+=stars[0].velX;
    }
  }
}
/*
this method computes the total force excerted to a star from the objects contained in the holes[] array.
this force vector is then translated to an acceleration vector and is finally added to the stars velocity vector.

 */
public static void calculateSome(Star[] holes, Star[] stars, float gConstant) { 
  for (int o = 0; o < holes.length; o++) {
    Star center = holes[o];
    for (int i = 0; i < stars.length; i++) {
      Star x=stars[i];
      if (x == center)
        continue;
      float r=sqrt((center.posX-x.posX)*(center.posX-x.posX)+(center.posY-x.posY)*(center.posY-x.posY));
      float angulo = abs(asin((center.posX-x.posX)/r));
      float g=(gConstant*center.mass*x.mass)/(r*r);
      float fx=abs((g)*sin(angulo));
      float fy=abs((g)*cos(angulo));
      if (center.posX < x.posX) {
        fx=fx*-1;
      }
      if (center.posY < x.posY) {
        fy=fy*-1;
      }

      x.velX+=fx/x.mass;
      x.velY+=fy/x.mass;
    }
  }
}
/*
the position of the stars are moved according to their velocity vector
 */
public static void moveStars(Star[] stars) {
  for (Star x : stars) {
    x.move();
  }
}
/*
this method does the same as the calculateSome method with the difference that
 the force computation takes into account every star instad of just the black holes
 */
public static void calculateAll(Star[] stars, float gConstant) {
  for (int i = 0; i < stars.length - 1; i++) {
    for (int o = i + 1; o < stars.length; o++) {
      Star x=stars[i];
      Star y = stars[o];
      if (x == null || y == null)
        continue;
      float r=sqrt((y.posX-x.posX)*(y.posX-x.posX)+(y.posY-x.posY)*(y.posY-x.posY));
      float angulo = abs(asin((y.posX-x.posX)/r));
      float g=(gConstant*y.mass*x.mass)/(r*r);
      float fx=abs((g)*sin(angulo));
      float fy=abs((g)*cos(angulo));
      if (y.posX < x.posX) {
        fx=fx*-1;
      }
      if (y.posY < x.posY) {
        fy=fy*-1;
      }
      x.velX+=fx/x.mass;
      x.velY+=fy/x.mass;
      y.velX-=fx/y.mass;
      y.velY-=fy/y.mass;
      x.move();
      y.move();
    }
  }
}
