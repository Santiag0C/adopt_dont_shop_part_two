require 'rails_helper'

RSpec.describe 'As a visitor when I visit /shelters/:id', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')
  end

  it 'can view all shelter information' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content(@raccoon_shelter.name)
    expect(page).to have_content("Address: #{@raccoon_shelter.address}")
    expect(page).to have_content("City: #{@raccoon_shelter.city}")
    expect(page).to have_content("State: #{@raccoon_shelter.state}")
    expect(page).to have_content("Zip: #{@raccoon_shelter.zip}")

    visit "/shelters/#{@dog_shelter.id}"

    expect(page).to have_content(@dog_shelter.name)
    expect(page).to have_content("Address: #{@dog_shelter.address}")
    expect(page).to have_content("City: #{@dog_shelter.city}")
    expect(page).to have_content("State: #{@dog_shelter.state}")
    expect(page).to have_content("Zip: #{@dog_shelter.zip}")
  end

  it 'can click on shelter name and go to shelter show page' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_link(@raccoon_shelter.name)

    click_on(@raccoon_shelter.name)

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

  it 'when a user visits /shelters/:id there is a link to that shelters pet page /shelters/:id/pets' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_link('Shelter Pets')

    click_on('Shelter Pets')

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/pets")
  end
end
