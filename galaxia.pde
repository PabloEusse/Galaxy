 //<>//
void setup() {
  size(1500, 1000);
  background(255);
  fill(0);
  collide();  //<>//
} 

Galaxy galaxy = new Galaxy(800, 0.005);
Star[] holes;
void draw() {
  background(255);
  galaxy.drawGalaxy(); //<>//
  calculateSome(holes, galaxy.stars, 0.05);
  moveStars(galaxy.stars);
}
/*
sets up to galaxies galaxies wth circular rotating stars.
a velocity vector is aded to galaxy one to get it moving.
same is done for galaxy two. Same vector but in the other direction.
A new galaxy is then created containing galaxy one and two.
*/
void collide(){
  Galaxy galaxy1 = new Galaxy(400, 0.05);
  galaxy1.setUp(3000, 300, 200, 200, 10);
  
  Galaxy galaxy2 = new Galaxy(400,0.05);
  galaxy2.setUp(2000, 1200, 600, 200, 10);
  
 
  int count = 0;
  for(Star x : galaxy1.stars) {
    x.velX += 0.5;
    galaxy.stars[count++] = x;
  }
  
  for(Star x : galaxy2.stars) {
    x.velX -= 0.5;
    galaxy.stars[count++] = x;
  }
   holes = new Star[2];
   holes[0] = galaxy1.stars[0];
   holes[1] = galaxy2.stars[0];
}
