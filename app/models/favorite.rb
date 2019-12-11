class Favorite
  attr_reader :total_c, :hash
  def initialize(content)
    @total_c = content || Hash.new(0)
  end
  def total_count
    @total_c.values.sum
  end
  def add_favorite(id)
    # binding.pry
    @total_c[id.to_s] = count_of(id)+1
  end
  def count_of(id)
    @total_c[id.to_s].to_i
  end
  def id_finder
    @pets = Pet.all
    hash = {}
    @total_c.each do |key, val|
    hash[@pets.find(key)]=1
   end
   return hash
  end
end
