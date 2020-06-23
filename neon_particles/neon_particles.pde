ParticleSystem ps;

void setup() {
  size(640,480);
  ps = new ParticleSystem(new PVector(width/2, height/2));
}

void draw() {
  background(0);
  ps.addParticle();
  ps.update();
  ps.onDraw();
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
  
  void onDraw() {
    for( Particle p: particles)
    {
      p.onDraw();
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
  
  void onDraw(){
    stroke(col, lifespan);
    fill(col, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }
  
  boolean isDead(){
    return lifespan < 0.0;
  }
}
