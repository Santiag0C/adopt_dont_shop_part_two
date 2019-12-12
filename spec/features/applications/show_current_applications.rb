require 'rails_helper'

RSpec.describe 'As A Visitor', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    end
    it "can display diferent mesages depending on if it has applications" do
  visit "/pets/#{@elena.id}"
  click_on('Favorite!')

  visit '/favorites'

  click_on('Adopt A Pet')

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

  click_on ('Submit Application')

  visit "/pets/#{@raccoon.id}"

  expect(page).to have_content("#{@raccoon.name} dosen't have any applications (¤﹏¤).")

  visit "/pets/#{@elena.id}"

  expect(page).to have_content("Current Applications for #{@elena.name}")

  end
end
