require 'rails_helper'

RSpec.describe 'as a vistitor', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
  end
  it 'can dislpay the favorites index page'do

    visit "/pets/#{@elena.id}"

    click_on('Add to Favorites')

    # visit "/pets/#{@foxy.id}"
    #
    # click_on('Add to Favorites')
    #
    click_on('Favorites: 1')

    expect(current_path).to eq('/favorites')

    # expect(page).to have_link(@foxy.name, href: "/pets/#{@foxy.id}")
    # expect(page).to have_css("img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']")

    expect(page).to have_link(@elena.name, href: "/pets/#{@elena.id}")
    expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")

    # within "#pet-#{@foxy.id}" do
      # click_on 'Remove from Favorite'
    # end
    # expect(current_path).to eq('/favorites')

    # within "#pet-#{@elena.id}" do
      click_on 'Remove from Favorite'
    # end

    # expect(page).to_not have_content(@foxy.name)
    # expect(page).to_not have_css("img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']")

    expect(page).to_not have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(current_path).to eq('/favorites')
    expect(page).to have_content('You have no favorites')
    # expect(page).to_not have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
  end
end
