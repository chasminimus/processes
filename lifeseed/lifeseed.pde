float r = 70;
ArrayList<Circle> circles = new ArrayList<Circle>();

int maxFrames = 120;
float t;

void setup() {
  size(500, 500);
  colorMode(HSB, 1.0);
  blendMode(ADD);
  ellipseMode(RADIUS);
  strokeWeight(4);
  stroke(1);
  pixelDensity(displayDensity());
  noFill();
  
  for (float p = -6; p <= 6; p++) {
    for (float q = -6; q <= 6; q++) {
      float x = r/sqrt(3) * (sqrt(3) * p + sqrt(3)/2 * q);
      float y = r/sqrt(3) * (3.0/2.0 * q);
      circles.add(new Circle(x, y, r));
    }
  }
}

void draw() {
  background(0);
  
  t = 1.0*frameCount / maxFrames;
  
  translate(width/2, height/2);
  rotate(PI/6);
  
  for (Circle circle : circles) {
    circle.render();
    //println(circle.rank);
  }
  
  if (frameCount <= maxFrames) {
    saveFrame("frames\\lifeseed###.png"); 
  }
  if (frameCount == maxFrames) {
    stop();
  }
}

class Circle {
   float x, y, r;
   float rank, angle;
   
   Circle(float x, float y, float r) {
     this.x = x;
     this.y = y;
     this.r = r;
     rank = dist(x, y, 0, 0);
     angle = atan2(y, x);

     rank = map(rank, 0, width/sqrt(2), 0, 1);
     angle = map(angle, -PI, PI, 0, 1);
   }
   
   void render() {
     float a = (cos(TAU*(t-rank) / 1) + 1) / 2;
     //float rr = r * (0.01*cos(TAU*(t-rank))+1);
     float rr = r;
     color c = color((angle + t) % 1, .75, 1);
     stroke(c, a);
     ellipse(x, y, rr, rr);
   }
}
