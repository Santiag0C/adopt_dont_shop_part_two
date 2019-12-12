class ApplicationsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def new
    pet_id = keys_to_i(favorites.contents)

    @pets = []
    pet_id.each do |id|
      @pets.push(Pet.find(id))
    end
  end

  def create
    application = Application.new(application_params)
    if application.save
      params[:pet_ids].each do |pet_id|
        ApplicationPet.create(pet_id: pet_id, application_id: application.id)
    end
    params[:pet_ids].each do |id|
    favorites.contents.delete(id)
    end
      redirect_to '/favorites'
      flash[:success] = 'Application Submitted!'
    else
      redirect_to '/applications/new'
      flash[:failure] = 'Fill Out All Fields!'
    end
  end

  def unapprove
    pet = Pet.find(params[:id_pet])
    pet.update(status: 'adoptable')
    redirect_to "/applications/#{pet.applications[0].id}"
  end
  def update
    params[:pet_ids].each do |pet_id|
      @pet = Pet.find(pet_id)
      @pet.update(status: 'pending')
    end
    if params[:pet_ids].count == 1
      # @applicant = Application.last.name
      redirect_to "/pets/#{@pet.id}"
    else
      redirect_to "/"
    end
  end

    ########### PRIVATE METHODS ###########

private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

  def pet_params
    params.permit(:image, :name, :description, :age, :sex, :status, :shelter_id)
  end
end
