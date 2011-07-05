module Moveable
  
  def move(direction)
    case direction
       when 'a'
         #move left
           self.location[0]-=1
       when 'd'
         self.location[0]+=1
         #move right
      when 's'
         #move down
           self.location[1]+=1
       when 'w'
         #move up
           self.location[1]-=1
     end
  end
end
