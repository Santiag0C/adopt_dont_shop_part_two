require 'rails_helper'

RSpec.describe 'As a visitor when I visit Shelter index page', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create!(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
  end

  it 'A new Shelter can be created' do
    visit '/shelters'

    expect(page).to have_link('New Shelter')

    click_link 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    name = 'Dragon Shelter'
    address = 'Dragon Road'
    city = 'Dragon City'
    state = 'Dragon State'
    zip = '80236'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_on 'Submit'

    expect(current_path).to eq('/shelters')

    expect(page).to have_content(name)
  end
end
