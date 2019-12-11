class ApplicationsController < ApplicationController

  def show
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

    ########### PRIVATE METHODS ###########

private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
