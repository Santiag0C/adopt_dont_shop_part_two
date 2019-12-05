class FavoritesController < ApplicationController

  def index
    @pets = Pet.all
    # @pet = pet.find(params[:pet_id])
    @favorites = Favorite.new(session[:favorites])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new
    session[:favorites][pet_id_str] ||= 0
    session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
    flash[:success] = "#{pet.name} has been favorited #{session[:favorites][pet_id_str]}"
    redirect_to "/pets/#{pet.id}"
  end

end
