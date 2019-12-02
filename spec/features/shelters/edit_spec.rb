require 'rails_helper'

RSpec.describe 'Shelter Update Page', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
  end

  it 'a user can update a shelter' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content(@raccoon_shelter.name)

    expect(page).to have_link('Update Shelter')

    click_link 'Update Shelter'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/edit")

    name = 'New Raccoon Shelter'
    address = 'New Raccoon Road'
    city = 'New Raccoon City'
    state = 'New Raccoon State'
    zip = '12345'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")

    expect(page).to have_content(name)
    expect(page).to have_content(address)
    expect(page).to have_content(city)
    expect(page).to have_content(state)
    expect(page).to have_content(zip)
    # expect(page).to_not have_content('Raccoon Shelter')
    # expect(page).to_not have_content('Raccoon Road')
    # expect(page).to_not have_content('Raccoon City')
    # expect(page).to_not have_content('Raccoon State')
    # expect(page).to_not have_content('80237')
  end
end
