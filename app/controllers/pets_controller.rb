class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def shelter_pets_index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    
    Pet.create(pet_params)

    redirect_to "/shelters/#{@shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update({
                 image: params[:image],
                 name: params[:name],
                 description: params[:description],
                 age: params[:age],
                 sex: params[:sex]
      })

      @pet.save

      redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])

    redirect_to '/pets'
  end

  ########### PRIVATE METHODS ###########

private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex, :status, :shelter_id)
  end
end
