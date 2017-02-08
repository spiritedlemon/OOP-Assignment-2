OOP-Assignment-2     --     DT - 228/2     --     Simon O'Leary ( C15413218 )


Embeded Video:
<iframe width="560" height="315" src="https://www.youtube.com/embed/SdqUIfFkASY" frameborder="0" allowfullscreen></iframe>

Youtube link:
https://www.youtube.com/watch?v=SdqUIfFkASY


Layout:
The functions used in MAIN are in the following order(Should help with navigating through as main is quite crowded):

setup()
(Global Variables)
menu()
mousePressed()
draw()
endGame()
endGame2()
onePlayer()
twoPlayer()
highScores()
spawn()
keyPressed()
keyReleased()
checkKey()


How to use:
When the game starts you are brought to a menu. This gives three options : One-Player/Two-Player/HighScores

One player is a classic game of ASTEROIDS where you shoot the objects and collect score. At certain points powerups drop and these
benefit you until you die. After finishing the game (when your lives are depleted) your score is written out to a text file.
At 1000, 5000 and 25000 points a power-up wil drop, increasing fire-rate or slowing asteroid movement

Two player is a different take on Asteroids. Instead of score its a survival mode where the two players work together to survive
as long as possible. They have a shared pool of lives and the time is displayed in seconds both during and after the game.

Highscores reads in from the save file and displays the highest scores using a sorting algorithm to determine the top three.

This game uses game objects to create the asteroids, powerUps, user's ship and the bullets fired. Unfortunately it doesn't look as polished as I'd like 
as I got side tracked by a number of features and their issues.





