require 'rails_helper'

RSpec.describe 'As a User', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')
  end

  it 'A User when i visit /pets you can see the image, name, approximate age, sex, and associated shelter of the pet' do
    visit '/pets'

    expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(page).to have_content(@elena.name)
    expect(page).to have_content(@elena.age)
    expect(page).to have_content(@elena.sex)
    expect(page).to have_content(@elena.shelter.name)

    expect(page).to have_css("img[src*='https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg']")
    expect(page).to have_content(@goblin.name)
    expect(page).to have_content(@goblin.age)
    expect(page).to have_content(@goblin.sex)
    expect(page).to have_content(@goblin.shelter.name)
  end

  it 'when i visit /shelters/:shelter_id/pets i see adoptable pets form that shelter, shelter id, and the pets image, name, sex, and age' do
    visit "/shelters/#{@raccoon_shelter.id}/pets"

    within "#pet-#{@elena.id}" do
      expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      expect(page).to have_content("Shelter ID: #{@elena.shelter.id}")
      expect(page).to have_content(@elena.name)
      expect(page).to have_content(@elena.age)
      expect(page).to have_content(@elena.sex)
    end

    within "#pet-#{@raccoon.id}" do
      expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      expect(page).to have_content("Shelter ID: #{@raccoon.shelter.id}")
      expect(page).to have_content(@raccoon.name)
      expect(page).to have_content(@raccoon.age)
      expect(page).to have_content(@raccoon.sex)
    end

      # expect(page).to_not have_css("img[src*='https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg']")
      # expect(page).to_not have_content("Shelter ID: #{@foxy.shelter.id}")
      # expect(page).to_not have_content(@foxy.name)
      # expect(page).to_not have_content(@foxy.age)
      # expect(page).to_not have_content(@foxy.sex)
  end

  it 'I can update a pet from pet index page' do
    visit '/pets'

    within "#pet-#{@elena.id}" do
      expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      expect(page).to have_content(@elena.shelter.name)
      expect(page).to have_content(@elena.name)
      expect(page).to have_content(@elena.age)
      # expect(page).to have_content(@elena.sex)

      expect(page).to have_link('Update Pet')

      click_on 'Update Pet'
    end
      expect(current_path).to eq("/pets/#{@elena.id}/edit")
  end

  it 'can click on shelter name and go to shelter show page' do
    visit "/pets"
    within "#pet-#{@elena.id}" do
      expect(page).to have_link(@raccoon_shelter.name)

      click_on(@raccoon_shelter.name)

      expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
    end
  end

  it 'I can update a pet from pet index page' do
    visit "/shelters/#{@raccoon_shelter.id}/pets"

    within "#pet-#{@elena.id}" do
      # expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      # expect(page).to have_content(@elena.shelter.name)
      # expect(page).to have_content(@elena.name)
      # expect(page).to have_content(@elena.age)
      # expect(page).to have_content(@elena.sex)

      expect(page).to have_link('Update Pet')
      click_on 'Update Pet'
      end

      expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/pets/#{@elena.id}/edit")
  end

  it 'visit pets index page there is a delete link for every pet' do
    visit '/pets'

    within "#pet-#{@elena.id}" do
      expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      expect(page).to have_content(@elena.shelter.name)
      expect(page).to have_content(@elena.name)
      expect(page).to have_content(@elena.age)
      expect(page).to have_content(@elena.sex)
      expect(page).to have_link('Delete Pet')
      click_on 'Delete Pet'
    end
    expect(current_path).to eq('/pets')
  end

  it 'visit shelter pets index page there is a delete link for every pet' do
    visit "/shelters/#{@raccoon_shelter.id}/pets"

    within "#pet-#{@elena.id}" do
      expect(page).to have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
      expect(page).to have_content(@elena.shelter.id)
      expect(page).to have_content(@elena.name)
      expect(page).to have_content(@elena.age)
      expect(page).to have_content(@elena.sex)
      expect(page).to have_link('Delete Pet')
      click_on 'Delete Pet'
    end
    expect(current_path).to eq('/pets')

    # expect(page).to_not have_css("img[src*='https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces']")
    expect(page).to_not have_content(@elena.shelter.id)
    expect(page).to_not have_content(@elena.name)
    expect(page).to_not have_content(@elena.age)
    # expect(page).to_not have_content(@elena.sex)
  end

  it 'can click on shelter name and go to shelter show page' do
    visit "/shelters/#{@raccoon_shelter.id}/pets"

    expect(page).to have_content(@raccoon_shelter.name)

    click_on(@raccoon_shelter.name)

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

    it 'pet name is a link that takes me to pet show page' do
      visit "/shelters/#{@raccoon_shelter.id}/pets"

      expect(page).to have_link(@elena.name)

      click_on(@elena.name)

      expect(current_path).to eq("/pets/#{@elena.id}")
    end
end
