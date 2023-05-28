--items should be tagged with what commands can work on them

interactables = {}

--this ion cannon will for the basis of enemy entities
ionCannoner = {}
ionCannoner.x = 80
ionCannoner.y = 80
ionCannoner.health = 5
ionCannoner.deathMessage = "With a single blow, the turret falls apart"
ionCannoner.hitMessage = "You punch the ion turret"
ionCannoner.altitude = 1

--helpers for all interactables (like a superclass) set to placeholders

function interactables.makeInteractable()
  
  local interactable = {}
  interactable.x = 0
  interactable.y = 0
  interactable.attachedEntities = {}
  
  --checks what entities are nearby the interactable
  function interactable:updateAttachments(room)
    
    self.attachedEntities = {}
    
    for i,entity in ipairs(room.entities) do
      if getDistance(self.x, self.y, entity.x, entity.y) < 2 then --maybe change the threshold distance later
        
        table.insert(self.attachedEntities, entity)
    
      end
    
    end
    
  end
  
  return interactable
  
end

function interactables.makeLadder(x,y,name)
  
  local ladder = interactables.makeInteractable()
  ladder.x = x
  ladder.y = y
  ladder.name = name
  
  ladder.description = "a steel ladder leading up to the turret's level"
  
  function ladder:shotBehavior()
    
    scenarioPrint("the bullet punches a hole in the ladder's steel")
    
  end
  
  function ladder:interactBehavior()
    
    if player.altitude == nil then
      scenarioPrint("you climb the ladder to the turret's level")
      player.altitude = 1
    elseif player.altitude == 1 then
      scenarioPrint("you climb down the ladder back to ground level")
      player.altitude = 0
    end
    
  end
  
  function ladder:meleeBehavior()
    
    scenarioPrint("Your fist bounces off the hard steel of the ladder.")
    
  end
  
  return ladder
  
end

function interactables.makeBox(x,y, name, spiceText)
  
  local box = interactables.makeInteractable()
  --overriding some of the superclass fields and adding some of our own
  box.x = x
  box.y = y
  box.name = name
  box.isCover = true
  
  --spice text is any extra info attatched to this specific box
  box.description = "a sturdy block of concrete."
  
  if spiceText ~= nil then
    box.description = box.description.." "..spiceText
  end
   
  function box:shotBehavior()
    
    scenarioPrint("the bullet impacts and cracks the block's concrete")
    
  end
  
  function box:interactBehavior()
    
    scenarioPrint("Fiddling with the concrete box does nothing. It's a concrete box.")
    
  end
  
  function box:meleeBehavior()
    
    scenarioPrint("Your fist hurts from punching the concrete box.")
    
  end
  
  return box
  
end






rooms = {}

--testing level
rooms[1] = {
  
  entryText = "You enter a room with an ion turret and a series of concrete blocks",
  description = "There's a series of sturdy concrete boxes in here (1),(2),(3),(4), each consecutively leading towards a ladder(5). The ladder leads to a higher platform, upon which rests an ion turret.",
  interactables = {
    ["1"] = interactables.makeBox(0, 0, "the concrete box (1)"),
    ["2"] = interactables.makeBox(15, 15, "the concrete box (2)"),
    ["3"] = interactables.makeBox(45, 45, "the concrete box (3)"),
    ["4"] = interactables.makeBox(65, 65, "the concrete box (4)"),
    ["5"] = interactables.makeLadder(80, 80, "the ladder (5)")
    
  },
  
  entities = {ionCannoner}
  
}



--manage all the interactables in the room
function updateRoom()
  
  for k,interactable in pairs(currentRoom.interactables) do
      
    interactable:updateAttachments(currentRoom)
    
    --update the entities (don't forget to update the non attached entities too)
    local loopCounter = 0
    for i,entity in ipairs(interactable.attachedEntities) do
      
      loopCounter = loopCounter + 1
      
      if entity.health <= 0 then
        scenarioPrint(entity.deathMessage)
        table.remove(currentRoom.entities, i)
      end
    
    end
    
  end
  
end


