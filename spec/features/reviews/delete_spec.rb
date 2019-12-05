require 'rails_helper'

RSpec.describe 'visit /shelters/:id show page', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @raccoon_shelter_review_1 = @raccoon_shelter.reviews.create(title: 'Why is there a raccoon shelter?', rating: 5, content: 'this is awesome', picture: 'https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg')
    @raccoon_shelter_review_2 = @raccoon_shelter.reviews.create!(title: 'This is pointless', rating: 1, content: 'No one should have a raccoon!')
    @dog_shelter_review_1 = @dog_shelter.reviews.create!(title: 'I found my dog foxy here', rating: 4, content: 'Not the dog I thought I was getting, but that is okay.')
  end

  it 'each shelter review has a functional delete link which redirects back to the page' do
    visit "/shelters/#{@raccoon_shelter.id}"

    within "#review-#{@raccoon_shelter_review_1.id}" do
      expect(page).to have_content(@raccoon_shelter_review_1.title)
      expect(page).to have_content(@raccoon_shelter_review_1.rating)
      expect(page).to have_content(@raccoon_shelter_review_1.content)
      expect(page).to have_css("img[src*='https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg']")
      expect(page).to have_link('Delete Review')
      click_on('Delete Review')
    end

    expect(page).to_not have_content(@raccoon_shelter_review_1.title)
    expect(page).to_not have_content(@raccoon_shelter_review_1.rating)
    expect(page).to_not have_content(@raccoon_shelter_review_1.content)
    expect(page).to_not have_css("img[src*='https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg']")
  end
end


# User Story 7, Delete a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page,
# I see a link next to each shelter review to delete the review.
# When I delete a shelter review I am returned to the shelter's show page
# And I should no longer see that shelter review
