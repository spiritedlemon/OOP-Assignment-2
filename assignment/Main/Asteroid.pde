//This class determines the appearance of the asteroids and how they re-act upon collision

class Asteroid extends GameObject
{
   float radius;
   int maxLimit = 1;    //This will be used to track the max number of asteroids at any one time [maybe]
   float limit = 0.05;
   PVector velocity;
   float theta;  //Used to decide direction of asteroid
   float speed = 80;
   
    
   public Asteroid(float x, float y, float radius)
   {
     pos = new PVector(x,y);
     forward = new PVector(0, 1);
     this.radius = radius;
     
     forward.x = random(-1, 1);  //Try keep to small numbers or moves to quickly
     forward.y = random(-1, 2);  //These are random numbers asssigned to an asteroid on creation to avoid it constantly changing direction
   }
   
   
   //void division()  //(Split & break arent allowed) - This function deals with how the asteroids split/divide upon impact
   {
     
   }
    
    
    //This fnc is used to move the asteroids
   void update()
   {
      //forward.x = random(-1, 1);  //Try keep to small numbers or moves to quickly
      //forward.y = random(-1, 2);
     
      pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));  //Causes the object to move 
      
      //below stops the asteroids leaving the screen [They re-appear on the other side]
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
     
     fill(0);
     ellipse(pos.x, pos.y, radius, radius);
     
     popMatrix();
   }
   
    
    
} 