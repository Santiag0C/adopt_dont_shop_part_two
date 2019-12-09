require 'rails_helper'

RSpec.describe 'Favorite Indicator in Nav Bar', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')
  end

  it 'There is a favorites indicator in navigation bar and each page, with favorites count from all views' do
    visit "/pets/#{@elena.id}"

    expect(page).to have_content('Favorites: 0')
    click_button('Favorite!')
    expect(current_path).to eq("/pets/#{@elena.id}")
    expect(page).to have_content('Favorites: 1')

    visit "/pets/#{@raccoon.id}"

    click_button('Favorite!')
    expect(page).to have_content('Favorites: 2')
  end

  it 'displays a flash message indicating that the pet has been favorited' do
    visit "/pets/#{@elena.id}"

    click_button('Favorite')
    expect(page).to have_content("#{@elena.name} has been favorited")
  end

  it 'Can click on favorites in the nav_bar and be redirected to favorites index /favorites' do
    visit '/'

    click_on('Favorites')

    expect(current_path).to eq('/favorites')
  end
end
