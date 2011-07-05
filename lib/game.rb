class Game
 
 
 
  def try_move(object, direction)
    ghost=GameObjectsFactory.create(object.symbol,object.location.clone)
    ghost.move(direction)
    occupying_object=@board.check_occupied(ghost.location)
    case occupying_object.symbol
      when " "
        object.move(direction)
        return true
      when "."
        object.move(direction)
        return true
      when "o"
        #if there's a barrel it should be moved only if there is nothing blocking it and if the pushing object is
        #not itself a barrel.
        if object.symbol !="o"
          try_move(occupying_object,direction) && object.move(direction)
        end
    end
  end
 
 
  def play(level)
 
    @levels=GetFromFile.get_levels
    @board=Board.new(@levels,level)
    @player=@board.game_objects.find{|go| go.symbol=="@"}
 
    while true do
      system('clear')
      if @board.show
        puts "You won"
        exit
      end
      direction=read_char
      direction=='r' && self.play(level) #restart
      direction=='q' && exit
      try_move(@player,direction)
    end
  end
 
  def read_char
    system "stty raw -echo"
    STDIN.getc
    ensure system "stty -raw echo"
  end


end
