require 'rails_helper'

RSpec.describe 'As a User', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')
  end

  it 'when is visit /pets/:id I see an id specific pet with image, name, description, approximate age, sex, adoptable/pending adoption status ' do
    visit "/pets/#{@elena.id}"

    expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(page).to have_content("Name: #{@elena.name}")
    expect(page).to have_content("Description: #{@elena.description}")
    expect(page).to have_content("Age: #{@elena.age}")
    expect(page).to have_content("Sex: #{@elena.sex}")
    expect(page).to have_content("Status: #{@elena.status}")

    expect(page).to_not have_content('alk;jdfaiosdjlfdksjaodsjadls;')
    expect(page).to_not have_css("img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']")
    expect(page).to_not have_content(@foxy.name)
    expect(page).to_not have_content(@foxy.age)
    # expect(page).to_not have_content(@foxy.sex)
  end

  it 'pet name is a link that takes me to pet show page' do
    visit "/pets/#{@elena.id}"

    expect(page).to have_link(@elena.name)

    click_on(@elena.name)

    expect(current_path).to eq("/pets/#{@elena.id}")
  end
end
