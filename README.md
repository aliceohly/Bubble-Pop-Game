# Bubble-Pop-Game
An iOS Swift bubble pop game that adopts MVP model.

In this game, a number of bubbles are randomly displayed on an iOS device screen. A player pops a bubble by touching the bubble, and every time they pop a bubble they earn a certain number of points. Bubbles come in five colours: red, pink, green, blue and black. Each colour corresponds to a specific number of points and has a specific probability of appearance. All bubbles appear on the screen briefly. A player needs to pop as many bubbles as possible within a certain timeframe (default to 60 seconds) to get high scores. Note that, if a player pops two or more bubbles of the same colour consecutively, they earn 1.5 times the points for the additional bubbles they pop. Finally, game scores are saved and a high score board is displayed after a game run is finished. 

Core components:
- A game timer (adjustable)
- A score (scores are saved, highest score is displayed)
- A player detail entered screen
- Bubbles (the amount is adjustable between 0 to 15)
  - Random color
  - Displayed within the screen
  - No overlapping
- Flashing count down 3,2,1 at the beginning
- Music player
