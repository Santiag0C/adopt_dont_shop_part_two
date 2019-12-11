require 'rails_helper'

RSpec.describe "as a visitor i can see the favorite couter on my nav bar" do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')

  end
  it 'can display a link in the pets show page to add them to favorites' do
    visit "/pets/#{@elena.id}"

    click_on('Add to Favorites')

    expect(current_path).to eq("/pets/#{@elena.id}")

    expect(page).to have_content("You have added #{@elena.name} to your favorites.")
    expect(page).to have_content('Favorites: 1')

    visit "/pets/#{@foxy.id}"

    click_on('Add to Favorites')

    expect(current_path).to eq("/pets/#{@foxy.id}")

    expect(page).to have_content("You have added #{@foxy.name} to your favorites.")
    expect(page).to have_content('Favorites: 2')

  end
#     User Story 9, Favorite Creation
#
# As a visitor
# When I visit a pet's show page
# I see a button or link to favorite that pet
# When I click the button or link
# I'm taken back to that pet's show page
# I see a flash message indicating that the pet has been added to my favorites list
# The favorite indicator in the nav bar has incremented by one
end
