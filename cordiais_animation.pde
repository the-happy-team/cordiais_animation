PImage lindaImg;
PImage[] squareImgs;

int NUM_SQS = 3;
String SQ_FILE = "sq_y_16px.png";
float DELTA_MAG;

PVector facePos = new PVector(0.22, 0.225);
float resizeFactor;

float maxPeriod = 8;
float[] nextUpdate;

PVector[] sqPos;

void setup() {
  size(1080, 1920);
  frameRate(30);

  lindaImg = loadImage("aladino-divani_retrato-de-linda-divani_fill-2.jpg");
  resizeFactor = float(width) / lindaImg.width;
  lindaImg.resize(width, 0);

  squareImgs = new PImage[NUM_SQS];
  for (int i = 0; i < squareImgs.length; i++) {
    squareImgs[i] = loadImage(SQ_FILE);
    squareImgs[i].resize(int(resizeFactor * squareImgs[i].width + 0.0155 * width), 0);
  }

  nextUpdate = new float[squareImgs.length];
  for (int i = 0; i < nextUpdate.length; i++) {
    nextUpdate[i] = 2 * i;
  }

  sqPos = new PVector[squareImgs.length];
  for (int i = 0; i < sqPos.length; i++) {
    sqPos[i] = new PVector(facePos.x * width, facePos.y * height);
  }

  DELTA_MAG = float(width) / 32.0;
}

void draw() {
  image(lindaImg, 0, 0);

  for (int i = 0; i < squareImgs.length; i++) {
    image(squareImgs[i], sqPos[i].x, sqPos[i].y);
  }

  for (int i = 0; i < squareImgs.length; i++) {
    if (frameCount > nextUpdate[i]) {
      float deltaX = 2.0 * noise(frameCount / 18.0, 2.0*i, PI) - 1.0;
      float deltaY = 2.0 * noise(frameCount / 18.0, 2.0*i, PI/2) - 1.0;
      //float newX = facePos.x * width + deltaX * 2.0 * DELTA_MAG;
      //float newY = facePos.y * height + deltaY * 2.0 * DELTA_MAG;

      float newX = facePos.x * width + random(-DELTA_MAG, DELTA_MAG);
      float newY = facePos.y * height + random(-DELTA_MAG, DELTA_MAG);

      sqPos[i].set(newX, newY);
      nextUpdate[i] = frameCount + random(maxPeriod);
    }
  }

  saveFrame("data/out/linda-####.png");
  if (frameCount > 900) exit();
}
