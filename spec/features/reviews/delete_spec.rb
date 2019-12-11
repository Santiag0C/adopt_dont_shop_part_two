require 'rails_helper'

RSpec.describe 'As a visitor i can delete reviews', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
  end
  it "can belete a specific review"do
    visit "/shelters/#{@raccoon_shelter.id}"

    click_on 'Create Review'

    fill_in :title, with: 'review title'
    fill_in :rating, with: 4
    fill_in :content, with: 'this product is greate'
    fill_in :picture, with: 'https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg'

    click_on 'Submit'

    expect(page).to have_content('review title')
    expect(page).to have_content(4)
    expect(page).to have_content('this product is greate')
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg']")

    click_on 'Delete Review'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
    
  end
#   User Story 7, Delete a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page,
# I see a link next to each shelter review to delete the review.
# When I delete a shelter review I am returned to the shelter's show page
# And I should no longer see that shelter review
end
