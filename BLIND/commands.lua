


commandFuncs = {}

function commandFuncs.interact(param)
  
  if param ~= nil then
    scenarioPrint("This command does not accept parameters")
  else
    
    if player.nearbyInteractable == nil then
      scenarioPrint("You are not standing by an interactable object")
    else
      
      player.nearbyInteractable:interactBehavior()
      
    end
    
  end
  
end

function commandFuncs.cover(param)
  
  if param ~= nil then
    scenarioPrint("This command does not accept parameters")
  else
    
    if player.isCovering then
      scenarioPrint("You stand up")
      player.isCovering = false
    elseif player.nearbyInteractable == nil then
      scenarioPrint("You are not standing next to cover")
    elseif player.nearbyInteractable.isCover == nil then
      scenarioPrint("This object cannot sustain cover")
    else
      scenarioPrint("You crouch behind cover")
      player.isCovering = true
    end
    
  end
  
end



function commandFuncs.look(param)
  
  if param == nil then
    
    scenarioPrint(currentRoom.description)
  
 else 
    
    --print a specific item description
    if currentRoom.interactables[param] ~= nil then
      scenarioPrint(currentRoom.interactables[param].description)
    else
      scenarioPrint("Object nowhere to be found")
    end
    
  end
end


function commandFuncs.move(param)
  
  
  if param ~= nil then
    
    player.movementTarget = currentRoom.interactables[param]
    
  end
    
  if player.movementTarget == nil then
    
    scenarioPrint("No movement target selected!")
    
  elseif player.movementTarget.altitude ~= player.altitude then
    scenarioPrint("you are not at the same height level as your movement target")
  else
    
    
    local xDistToTarget = player.movementTarget.x - player.x
    local yDistToTarget = player.movementTarget.y - player.y
    
    local distToTarget = getDistance(player.x, player.y, player.movementTarget.x, player.movementTarget.y)
    
    
    if distToTarget > 5 then 
      player.x = player.x + (xDistToTarget/distToTarget)*player.speed
      player.y = player.y + (yDistToTarget/distToTarget)*player.speed
      
      scenarioPrint("moving towards ".. player.movementTarget.name)
      
      --clear out nearby interactable if you move away from the nearby interactable
      player.nearbyInteractable = nil
      
    else 
      scenarioPrint("arrived at " .. player.movementTarget.name)
      player.nearbyInteractable = player.movementTarget
      
    end
    
  end
  
  
end

function commandFuncs.melee(param)
    
  if param ~= nil then
    scenarioPrint("This command does not accept parameters")
  else
    
    if player.nearbyInteractable == nil then
      scenarioPrint("You punch at nothing.")
    else
      
      
      if player.nearbyInteractable.attachedEntities[1] == nil then
        
        player.nearbyInteractable:meleeBehavior()
        
      else
        
        if player.altitude == player.nearbyInteractable.attachedEntities[1].altitude then
          --do damage to entity
          player.nearbyInteractable.attachedEntities[1].health = player.nearbyInteractable.attachedEntities[1].health - 5
          
          scenarioPrint(player.nearbyInteractable.attachedEntities[1].hitMessage)
          
        else 
          scenarioPrint("you are not at the correct height to punch your target")
        end
        
      end
      
    end
    
  end
  
end

function commandFuncs.talk(param)
  
  
  if param == nil then
    scenarioPrint("but I've nothing to say :)")
  else
    scenarioPrint(param)
  end
  
end




commands = {
  
  l = commandFuncs.look,
  c = commandFuncs.cover,
  m = commandFuncs.move, -- experiment with different movement controls
  f = commandFuncs.melee,
  s = commandFuncs.shoot,
  i = commandFuncs.interact,
  t = commandFuncs.talk -- my wonderful testing command
  
  }