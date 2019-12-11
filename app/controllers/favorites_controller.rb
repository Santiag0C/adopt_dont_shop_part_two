class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = Favorite.new(session[:favorites])
  end
  def update
    pet = Pet.find(params[:id])
    @favorites = Favorite.new(session[:favorites])
    @favorites.add_favorite(pet.id)
    session[:favorites] = @favorites.total_c
    @favorites.count_of(pet.id)
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{pet.id}"
  end
  def destroy
    pet = Pet.find(params[:id])
    @favorites = Favorite.new(session[:favorites])
    @favorites.total_c.delete(pet.id.to_s)
    flash[:notice] = "You have unfavorited #{pet.name} (¤﹏¤)."
    if request.referrer.include?"favorites"
      redirect_to "/favorites"
    else
      redirect_to "/pets/#{pet.id}"
    end
  end
  def destroy_all
    @favorites = Favorite.new(session[:favorites])
    @favorites.total_c.clear
    redirect_to "/favorites"
  end
end
