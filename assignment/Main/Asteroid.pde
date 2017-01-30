//This class determines the appearance of the asteroids and how they re-act upon collision

class Asteroid extends GameObject
{
   float radius;
   int maxLimit = 1;    //This will be used to track the max number of asteroids at any one time [maybe]
   float limit = 0.05;
   PVector position;
   PVector velocity;
   PVector rotation;
   float spin;
    
   public Asteroid(PVector pos, float radius)
   {
     this.position = pos;
     this.radius = radius;
     float angle = random(2 * PI);
     velocity = new PVector(cos(angle), sin(angle));
     velocity.mult((50*50)/(radius*radius));
     angle = random(2 * PI);
      
     rotation = new PVector(cos(angle), sin(angle));
     spin = (float)(Math.random()*limit-limit/2);
      
     
   }
   
   void division()  //(Split & break arent allowed) - This function deals with how the asteroids split/divide upon impact
   {
     
   }
    
    
   void update()
   {
     
   }
   
   void render()
   {
     
   }
   
    
    
} 