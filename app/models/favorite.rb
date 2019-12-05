class Favorite
  def initialize(initial_contents)
    @contents =  initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end
end
