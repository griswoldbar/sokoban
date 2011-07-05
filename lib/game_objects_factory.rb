 
class GameObjectsFactory
 
  def self.create(symbol,location)
    case symbol
      when '@'
        Player.new(symbol,location)
      when 'o'
        Barrel.new(symbol,location)
      when '.'
        Shelf.new(symbol,location)
      when '#'
        Wall.new(symbol,location)
      else
        Blank.new(symbol,location)     
    end
  end
 
end
