require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
  end

  it 'A User can Delete a shelter on a /shleters/:id page' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content(@raccoon_shelter.name)
    expect(page).to have_content(@raccoon_shelter.address)
    expect(page).to have_content(@raccoon_shelter.city)
    expect(page).to have_content(@raccoon_shelter.state)
    expect(page).to have_content(@raccoon_shelter.zip)

    expect(page).to have_link('Delete Shelter')

    click_on 'Delete Shelter'

    expect(current_path).to eq('/shelters')

    expect(page).to_not have_content(@raccoon_shelter.name)
  end
end
