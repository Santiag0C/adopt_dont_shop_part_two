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

  it 'when a User visits a pet show page they can update the pet' do
    visit "/pets/#{@elena.id}"

    expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(page).to have_content("Name: #{@elena.name}")
    expect(page).to have_content("Description: #{@elena.description}")
    expect(page).to have_content("Age: #{@elena.age}")
    expect(page).to have_content("Sex: #{@elena.sex}")
    expect(page).to have_content("Status: #{@elena.status}")

    expect(page).to have_link('Update Pet')

    click_link 'Update Pet'

    expect(current_path).to eq("/pets/#{@elena.id}/edit")

    # image = 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg'
    name = 'Foxy'
    description = 'Foxy does not look like a raccoon but she is'
    approximate_age = 5
    sex = 'Female'

    fill_in :image, with: "img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']"
    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :age, with: approximate_age
    fill_in :sex, with: sex

    click_on 'Submit'

    expect(current_path).to eq("/pets/#{@elena.id}")

    expect(page).to have_css("img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']")
    expect(page).to have_content(name)
    expect(page).to have_content(description)
    expect(page).to have_content(approximate_age)
    expect(page).to have_content(sex)

    expect(page).to_not have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(page).to_not have_content(@elena.name)
    expect(page).to_not have_content("Description: #{@elena.description}")
    expect(page).to_not have_content("Age: #{@elena.age}")
    # expect(page).to_not have_content("Sex: #{@elena.sex}")
    # expect(page).to_not have_content("Status: #{@elena.status}")
  end
end
