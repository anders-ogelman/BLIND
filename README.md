# BLIND
BLIND is an experimental text-based action game made with LOVE2D. 
This is a short demo in which the player must fight an ion turret. They begin on the floor, while the turret is on a raised platform with a ladder that the player can climb. There are three concrete boxes on the floor between the player and the ladder, which the player must utilize as cover while running towards the ladder. They can then climb the ladder and disable the turret by punching it. This all occurs in real time, and the ion turret will shoot at the player at regular intervals, so the player must learn to type and think quickly. 

Player commands:
l - Look; provides a description of the environment. Interactable items will be given a number in this description which can be used to select specific interactable items in other commands.
l (integer parameter) - Look at object; used to get a description of a specic numberet item in the room.
m (integer parameter) - Move by a single increment towards the object with the specified number.
m - Move towards the object previously set as a movement target with the m (integer parameter) command. Note that this moves the player only by a single increment, so the player must repeatedly execute this command until the console informs them that they have arrived at their destination.
f - Performs a melee attack (punch) against any interactable entity or enemy that the player is next to.
c - If the player is beside an interactable entity that can function as cover, the player will take cover. If they are already crouching, this command will cause them to stand up. When the player is taking cover, they cannot move or attack.
i - Interact with an interactable entity the player is standing next to. This can have a wide variety of effects. 

HOW TO RUN:
Download the "BLIND" foler from this repo, and then download LOVE 11.4 from https://love2d.org/. Simply drag the BLIND foler onto the love.exe file.
