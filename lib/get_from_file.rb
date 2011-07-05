class GetFromFile
 
 
  def self.get_levels
    level_data=IO.readlines('../lib/levels.sok')
    levels=[]
    level=[]
    level_data.each do |line|
      if line != "\n"
        level<<line
      else
        levels<<level
        level=[]
      end
    end
    levels
  end
 
end
