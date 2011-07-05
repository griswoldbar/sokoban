class Board
 
  attr_accessor :game_objects, :layout
 
  def initialize(levels, level_id)
     @game_objects=get_game_objects(levels, level_id)
  end
 
  def get_game_objects(levels,level_id)
    game_objects=[]
    level=levels[level_id-1]
    linecount=0
      level.each do |line|
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
    game_objects
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
