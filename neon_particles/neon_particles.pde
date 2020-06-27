ParticleSystem ps;
PGraphics pg;
PGraphics pg2;

void setup() {
  size(640,480);
  pg = createGraphics(640,480);
  pg2 = createGraphics(640,480);
  
  ps = new ParticleSystem(new PVector(width/2, height/2));
}

void draw() {
  background(0);
  ps.addParticle();
  ps.update();
  
  pg.beginDraw();
  pg.clear();
  ps.onDraw(pg, false);
  pg.endDraw();
  
  pg2.beginDraw();
  pg2.clear();
  ps.onDraw(pg2, true);
  pg2.endDraw();
  
  //pg.filter(BLUR,4);
  image(pg, 0, 0);
  //image(pg2, 0, 0);
  blend(pg2, 0, 0, width, height, 0, 0, width, height, LIGHTEST);
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector center) {
     origin = center.copy();
     particles = new ArrayList<Particle>();
  }
  
  void addParticle() {
   particles.add(new Particle(origin)); 
  }
  
  void update() {
    for( int i = particles.size() - 1; i >= 0; i--)
    {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) {
         particles.remove(i); 
      }
    }
  }
  
  void onDraw(PGraphics _p, boolean drawWhite) {
    for( Particle p: particles)
    {
      p.onDraw(_p, drawWhite);
    }
  }
}

class Particle {
  PVector position, velocity, acceleration;
  float lifespan;
  color col;
  
  Particle(PVector loc){
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-2, 2), random(-2, 2));
    position = loc.copy();
    lifespan = 255.;
    col = color(int(random(2)) * 255, int(random(2)) * 255, int(random(2)) * 255);
  }
  
  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }
  
  void onDraw(PGraphics p, boolean drawWhite){
    p.stroke(drawWhite ? 255 : col, lifespan);
    p.fill(drawWhite ? 255 : col, lifespan);
    p.ellipse(position.x, position.y, drawWhite?8:16, drawWhite?8:16);
  }
  
  boolean isDead(){
    return lifespan < 0.0;
  }
}
