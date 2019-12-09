class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents =  initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def keys_to_i(contents)
    pet_id_int = []
    @contents.each do |pet_id, quantity|
      pet_id_int.push(pet_id.to_i)
    end
    pet_id_int
  end
end
