require 'rails_helper'

RSpec.describe 'As A Visitor when I go to /pets/:id', type: :feature do
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

  it 'if a pet has been favorited its show page has remove pet from favorites link' do
    visit "/pets/#{@elena.id}"

    click_on('Favorite!')

    expect(page).to have_content('Favorites: 1')
    expect(page).to_not have_button('Favorite!')
    expect(page).to have_button('Unfavorite!')

    click_on('Unfavorite!')

    expect(current_path).to eq("/pets/#{@elena.id}")
    expect(page).to have_button('Favorite!')
    expect(page).to have_content('Favorites: 0')
    expect(page).to have_content("This Pet has been Unfavorited!")
  end

# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
end
