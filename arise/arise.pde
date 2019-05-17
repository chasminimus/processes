float centX, centY;
PVector vTop, vLeft, vRight, vSide;
float radius = 750;
float sideLength, triHeight;
color col1, col2;
PGraphics paper, triMask;

boolean papered = false;

void setup() {
  size(2736, 1824);
  //size(1000, 800);
  centX = width / 2;
  centY = height / 2;
  
  noLoop();
  colorMode(HSB, 1.0);
  noStroke();
  ellipseMode(RADIUS);
  
  vTop = new PVector(radius * cos(HALF_PI), radius * -sin(HALF_PI));
  vRight = new PVector(radius * cos(TWO_PI - PI/6), radius * -sin(TWO_PI - PI/6));
  vLeft = new PVector(radius * cos(PI + PI/6), radius * -sin(PI + PI/6));
  vSide = PVector.sub(vLeft, vTop);
  sideLength = vSide.mag();
  triHeight = .5 * sqrt(3) * sideLength;
  
  triMask = createGraphics(width, height);
  triMask.beginDraw();
  triMask.noStroke();
  triMask.colorMode(HSB, 1.0);
  triMask.background(0);
  triMask.fill(.1);
  triMask.translate(centX, radius + (height - triHeight)/2);
  triMask.triangle(vTop.x, vTop.y, vRight.x, vRight.y, vLeft.x, vLeft.y);
  triMask.endDraw();
  texture();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    col1 = color(random(1), random(.9), random(.3)+.7);
    col2 = color(random(1), random(.9), random(.1)+.1);
  }
  if (mouseButton == RIGHT) {
    papered = !papered;
    if (papered) {
      texture();
    }
  }
  redraw();
}

void keyPressed() {
  if (key == 's') {
    saveFrame("arise-###.png");
  }
}

void draw() {
  background(.9);
  
  pushMatrix();
  translate(centX, radius + (height - triHeight)/2);
  
  beginShape(TRIANGLE_FAN);
  vertex(vRight.x, vRight.y);
  for (float i = 0; i <= 7; i++) {
    PVector dv = PVector.mult(vSide, i/7);
    color pieceColor = lerpColor(col1, col2, i/7); 
    stroke(pieceColor);
    fill(pieceColor);
    vertex(vTop.x + dv.x, vTop.y + dv.y);
  }
  endShape();
  popMatrix();

  if (papered) {
    blendMode(ADD);
    image(paper, 0, 0);
    blendMode(NORMAL);
  }
}

void texture() {
  paper = createGraphics(width, height);
  paper.beginDraw();
  paper.colorMode(HSB, 1.0);
  paper.noStroke();
  paper.clear();
  
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      paper.fill(pow(random(1), 10), random(1));
      paper.rect(i, j, random(10), random(5));
    }
  }
  paper.filter(BLUR, 1);
  paper.endDraw();
  paper.mask(triMask);
}
  