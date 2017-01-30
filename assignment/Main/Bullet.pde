//This class is used to determine the velocity, start point and visual of the bullets fired in game
//Also used to determine how they act upon collision with other objects

class Bullet extends GameObject 
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
    line(0, - size / 2, 0, size / 2);  //The shape it will take
    popMatrix();
    
  }
  
  void update() // Overrides the method in the base class
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);      //These decide the direction the bullet travels and its orientation
    
    
    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));  //Causes the bullet to move forward
    if (pos.x > width)
    {
      pos.x = 0;
    }
    if (pos.x < 0)
    {
      pos.x = width;
    }
    if (pos.y > height)
    {
      pos.y = 0;
    }
    if (pos.y < 0)
    {
      pos.y = height;
    }
    alive += timeDelta;
    if (alive > timeLeft)
    {
      gameObjects.remove(this);  //This removes the bullet after a few seconds
    }
    
    
    
    
  }
  
  
}