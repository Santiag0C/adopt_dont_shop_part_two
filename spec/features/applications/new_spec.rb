require 'rails_helper'

RSpec.describe 'As A Visitor', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')

    # @david_application = Application.create!(name: 'David', address: '4942 Willow Street', city: 'Denver', state: 'Colorado', zip: 80238, phone_number: 7209510554, description: 'I treat all animals well.')
    # @scott_application = Application.create!(name: 'Scott', address: '4942 willow street', city: 'denver', state: 'colorado', zip: 80238, phone_number: 1234567890, description: 'I should not be given this responsibility!')
    # @david_application_pets = ApplicationPet.create!(application_id: @david_application.id, pet_id: @elena.id, pet_id: @raccoon.id, pet_id: @foxy.id)
  end

  it 'has a functional application link on /favorites where i can choose which pets it applies to' do
    visit "/pets/#{@elena.id}"
    click_on('Favorite!')
    visit "/pets/#{@raccoon.id}"
    click_on('Favorite!')
    visit "/pets/#{@foxy.id}"
    click_on('Favorite!')
    visit '/favorites'
    click_on('Adopt A Pet')
    expect(current_path).to eq('/applications/new')

    name = 'David Gomez'
    address = '4942 Willow Street'
    city = 'Denver'
    state = 'Colorado'
    zip = 80238
    phone_number = 7209510554
    description = 'I will be amazing'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :phone_number, with: phone_number
    fill_in :description, with: description
    find("#checkbox-#{@elena.id}").set(true)
    # check("pet_ids")

    click_on 'Submit Application'

    expect(current_path).to eq('/favorites')
    expect(page).to have_content('Application Submitted!')
    # within "#pet-#{@elena.id}" do
    #   expect(page).to_not have_content(@elena.name)
    # end
    # expect(page).to_not have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
  end

  it 'if an application is not completed you are redirected back to the page with a flash message' do
    visit '/applications/new'
    click_on('Submit Application')
    expect(current_path).to eq('/applications/new')
    expect(page).to have_content('Fill Out All Fields!')
  end
end
