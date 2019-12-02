require 'rails_helper'

RSpec.describe 'As a visitor when I visit /shelters', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
  end

  it 'shows the name of each shelter in the system' do
    visit '/shelters'

    expect(page).to have_content(@raccoon_shelter.name)
    expect(page).to have_content(@dog_shelter.name)
    expect(page).to have_content(@cat_shelter.name)
  end

  it 'There is a link to edit each shelter on the index page' do
    visit '/shelters'

    within "#shelter-#{@raccoon_shelter.id}" do
      expect(page).to have_content(@raccoon_shelter.name)

      expect(page).to have_link('Update Shelter')

      click_on ('Update Shelter')
    end

      expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

  it 'There is a link to delete each shelter on the index page' do
    visit '/shelters'

    within "#shelter-#{@raccoon_shelter.id}" do
      expect(page).to have_content(@raccoon_shelter.name)
      expect(page).to have_link('Delete Shelter')

      click_on 'Delete Shelter'
    end

      expect(current_path).to eq('/shelters')

      expect(page).to_not have_content(@raccoon_shelter.name)
  end

  it 'can click on shelter name and go to shelter show page' do
    visit '/shelters'

    expect(page).to have_link(@raccoon_shelter.name)

    click_on(@raccoon_shelter.name)

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

  it 'has a home page /' do
    visit '/'

    expect(page).to have_link('Home')
    expect(page).to have_link('Shelters')
    expect(page).to have_link('Pets')
  end
end
