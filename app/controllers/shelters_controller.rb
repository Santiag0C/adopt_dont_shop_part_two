class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new

  end

  def create
    Shelter.create(shelter_params)

    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update({
                     name: params[:name],
                     address: params[:address],
                     city: params[:city],
                     state: params[:state],
                     zip: params[:zip]
      })
    @shelter.save
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    # binding.pry
    Shelter.destroy(params[:id])

    redirect_to '/shelters'
  end

########### PRIVATE METHODS ###########

private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
