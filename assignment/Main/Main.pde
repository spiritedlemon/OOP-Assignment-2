//C15413218 - Simon O'Leary - DT228/2 OOP Assignment 2

//Game is called Asteroids: The player shoots asteroids which explode and give score
//Score or Round??

void setup()
{
  
  size(720, 640);  //Recommended ~720,640 -- smaller screen makes it harder to dodge asteroids
  
  //Pass the info into the userShip class to create their ship controls - This allows the creation of multiple players easily which makes a multiplayer mode easier
  UserShip player1 = new UserShip(width / 2, height / 2, 0, 30, 'w', 's', 'a', 'd', ' '); 
  
  
  gameObjects.add(player1);
}

//Variables
float timeDelta = 1.0f / 60.0f; //This variable tracks time passing - Used to kill bullets that have been alive too long

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];  //Used to discern if a key is being held down


void draw()
{
  background(0);
  stroke(255);  //Assigns color to objects being created in game
  
  for (int i = gameObjects.size() -1 ; i >= 0  ; i --)
  {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();    
  }
}



//Two functions used to discern if a key is being held down or not
void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}



//This function is used in the UserShip class to assign momentum to the ship
boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];  
  }
  return false;
}