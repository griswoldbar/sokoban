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
  
class Barrel<GameObject
  include Moveable
end
  
class Player<GameObject
  include Moveable
end
  
class Wall<GameObject
  
end
  
class Blank<GameObject
  
end
  
class Shelf<GameObject
  
end
  
  
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
      when ' '
        Blank.new(symbol,location)     
     end
  
  end
  
end
  
  
class GetFromFile
  
  def self.get_stuff
    game_objects=[]
    File.open('level1.sok') do |f|
       linecount=0
       f.each do |line|
         charcount=0
         line.chomp.split(//).each do |char|
             game_objects<<GameObjectsFactory.create(char,[charcount,linecount])
             if char=="@" or char=="o"
               game_objects<<GameObjectsFactory.create(" ",[charcount,linecount])
             end
             charcount+=1
           end
           linecount+=1
       end
     end
     game_objects
  end
  
end
  
class Board
  
  attr_accessor :game_objects, :layout
  
  def initialize()
     @game_objects=GetFromFile.get_stuff
  end
  
  def list
    @game_objects.each {|x| puts "#{x.location}  #{x.class}"}
     return true
  end
  
  def render
    @layout=[]
     temp_loc=nil
     @game_objects.each do |go|
       if go.location != temp_loc
         @layout<<go
       end
       temp_loc=go.location.clone
     end
  end
  
  def show
    self.game_objects.sort!
    self.render
     output_line=""
     current_row=0
     check_win=true
     @layout.each do |go|
       if go.symbol=='.'
         check_win=false
       end
       go_row = go.location[1]
       if go_row == current_row
         output_line=output_line+go.symbol
       else
         current_row=go_row
           puts output_line
           output_line=""+go.symbol
       end
     end
     puts output_line
     return check_win
  end
  
  def check_occupied(loc)
    self.game_objects.select{|go| go.location==loc}[0]
  end
  
end
  
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
  
  def play
    @board=Board.new
     @player=@board.game_objects.find{|go| go.symbol=="@"}
     while true do
       system('clear')
       if @board.show
         puts "You won"
           exit
       end
       direction=read_char
       direction=='r' && self.play #restart
       direction=='q' && exit
       try_move(@player,direction)
     end
  end
  
def read_char
system "stty raw -echo"
STDIN.getc
ensure
system "stty -raw echo"
end
  
end
  
game=Game.new
game.play

