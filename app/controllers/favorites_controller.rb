class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.new(session[:favorites])

    pet_id = keys_to_i(@favorites.contents)

    @pets = []
    pet_id.each do |id|
      @pets.push(Pet.find(id))
    end
    # binding.pry
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
    # keys_to_i(favorites.contents)
    favorites.contents.delete(params[:pet_id])
    flash[:notice] = "This Pet has been Unfavorited!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def destroy_favorite
    # keys_to_i(favorites.contents)
    # @favorites.contents.delete(params[:pet_id])
    # @pets
    # keys_to_i(favorites.contents).delete(params[:pet_id])
    # binding.pry
    # redirect_to '/favorites'
  end

end
