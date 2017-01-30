class Bullet extends GameObject // Gets everything from GameObject
{
  
  PVector pos;
  PVector forward;
  float theta;
  float size;
  float speed = 200;
  float timeLeft;
  float alive;
  
  
  Bullet(float x, float y, float theta, float size, float timeLeft)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, 1);
    this.theta = theta;
    this.size = size;
    this.timeLeft = timeLeft;    
    this.alive = 0;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);      //This is to decide where the bullet originates from
    rotate(theta);
    line(0, - size / 2, 0, size / 2);
    popMatrix();
    
  }
  
  
  
  
}