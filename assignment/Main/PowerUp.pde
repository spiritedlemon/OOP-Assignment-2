class PowerUp extends GameObject
{
  
  
  
   PowerUp(float x, float y)
   {
     
     pos = new PVector(x,y);
     
   }
   
   void update()
   {
     
   }
    
   void render()
   {
      
     pushMatrix();
      
      fill(255, 255, 0);
     rect(pos.x, pos.y, 50, 50);
      
     popMatrix();
      
  }
  
}//end of power up class