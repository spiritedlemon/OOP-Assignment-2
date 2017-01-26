//C15413218 - Simon O'Leary - DT228/2 OOP Assignment

//Game is called Asteroids: The player shoots asteroids which explode and give score
//Randomly space ships show up and shoot back

void setup()
{
  size(500, 500);
  //Pass the info into the userShip class to create their ship controls
  UserShip player1 = new UserShip(width / 2, height / 2, 0, 50, 'w', 's', 'a', 'd', ' '); 
  
  
  gameObjects.add(player1);
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void draw()
{
  background(0);
  
  for (int i = gameObjects.size() -1 ; i >= 0  ; i --)
  {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();    
  }
}