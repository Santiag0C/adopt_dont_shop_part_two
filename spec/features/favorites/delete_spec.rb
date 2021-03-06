require 'rails_helper'

RSpec.describe 'As A Visitor when I go to /favorites', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')

    @david_application = Application.create!(name: 'David', address: '4942 Willow Street', city: 'Denver', state: 'Colorado', zip: 80238, phone_number: 7209510554, description: 'I treat all animals well.')
    @scott_application = Application.create!(name: 'Scott', address: '4942 willow street', city: 'denver', state: 'colorado', zip: 80238, phone_number: 1234567890, description: 'I should not be given this responsibility!')
  end

  it 'I can unfavorite each pet which redirects me back to /favorites' do
    visit "/pets/#{@elena.id}"
    click_on 'Favorite!'

    visit '/favorites'
    # save_and_open_page
    expect(page).to have_link('Unfavorite!')
    click_on 'Unfavorite!'

    # expect(current_path).to eq("/favorites/#{@elena.id}")
    expect(current_path).to eq('/favorites')
    visit '/favorites'
    # save_and_open_page
    # expect(page).to_not have_content(@elena.name)

    #   User Story 13, Remove a Favorite from Favorites Page
    #
    # As a visitor
    # When I have added pets to my favorites list
    # And I visit my favorites page ("/favorites")
    # Next to each pet, I see a button or link to remove that pet from my favorites
    # When I click on that button or link to remove a favorite
    # A delete request is sent to "/favorites/:pet_id"
    # And I'm redirected back to the favorites page where I no longer see that pet listed
    # And I also see that the favorites indicator has decremented by 1
  end

  it 'A user can remove all favorites from the favorites page' do
    visit "/pets/#{@elena.id}"
    click_on('Favorite!')
    visit "/pets/#{@foxy.id}"
    click_on('Favorite!')
    visit '/favorites'

    expect(page).to have_content(@elena.name)
    expect(page).to have_content(@foxy.name)
    expect(page).to have_content('Favorites: 2')
    # expect(page).to have_link('Remove all Favorites!')
    expect(page).to have_button('Remove all Favorites!')

    click_on('Remove all Favorites!')

    # expect(current_path).to eq('/favorites/delete')
    expect(page).to_not have_content(@elena.name)
    expect(page).to_not have_content(@foxy.name)
    expect(page).to have_content('Favorites: 0')
  end
end
