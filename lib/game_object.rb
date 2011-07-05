class GameObject
  include Comparable
  attr_accessor :symbol, :location
 
  def initialize(symbol,location)
    @symbol=symbol
    @location=location
  end
 
  def <=>(other_object)
    x=(self.location[1]<=>other_object.location[1])
    if x!=0
      return x
    else
      x=(self.location[0]<=>other_object.location[0])
      if x!=0
        return x
      elsif self.class==Barrel || self.class==Player
        return -1
      else
        return 1
      end
    end
  end
end

