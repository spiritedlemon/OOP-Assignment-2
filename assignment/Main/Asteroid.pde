//This class determines the appearance of the asteroids and how they re-act upon collision

class Asteroid extends GameObject
{
   float radius;
   int maxLimit = 1;    //This will be used to track the max number of asteroids at any one time [maybe]
   float limit = 0.05;
   PVector velocity;
   float theta;  //Used to decide direction of asteroid
   float speed = 100;
   
    
   public Asteroid(float x, float y, float radius)
   {
     pos = new PVector(x,y);
     forward = new PVector(0, 1);
     this.radius = radius;
     float angle = random(2 * PI);
     velocity = new PVector(cos(angle), sin(angle));
     velocity.mult((50*50)/(radius*radius));
     //angle = random(2 * PI);
      
     //theta = new PVector(cos(angle), sin(angle));
      
   }
   
   
   //void division()  //(Split & break arent allowed) - This function deals with how the asteroids split/divide upon impact
   {
     
   }
    
    
    //This fnc is used to move the asteroids
   void update()
   {
      forward.x = random(0, 0.9);  //Try keep to small numbers or moves to quickly
      forward.x = random(1, 1.9);
     
      pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));  //Causes the object to move and (below) stops it leaving the screen
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
     
   }
   
   void render()
   {
     pushMatrix();
     
     ellipse(pos.x, pos.y, radius, radius);
     
     popMatrix();
   }
   
    
    
} 