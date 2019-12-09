class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.new(session[:favorites])
    # binding.pry

    pet_id = @favorites.keys_to_i

    @pets = []
    pet_id.each do |id|
      @pets.push(Pet.find(id))
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new
    session[:favorites][pet_id_str] ||= 0
    session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
    flash[:success] = "#{pet.name} has been favorited"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    favorites
    # favorites.delete(params[:pet_id])
    binding.pry
  end

end
