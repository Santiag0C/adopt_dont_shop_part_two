require 'rails_helper'

RSpec.describe 'review update page', type: :feature do

  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @review_1 = @raccoon_shelter.reviews.create(title: "title 1", rating: 4, content: "content of review 1", picture: 'https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg')
  end
  it 'can click a button to edit the review in a shelter' do

    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content('Edit Review')

    click_on 'Edit Review'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/#{@review_1.id}/edit")

    fill_in :title, with: 'updated review'
    fill_in :rating, with: 3
    fill_in :content, with: 'this product is ok'
    fill_in :picture, with: 'https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg'

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")

    expect(page).to have_content(3)
    expect(page).to have_content('this product is ok')
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg']")
    expect(page).to have_content('Edit Review')
  end
  it 'can show a flash message if i dont fill' do
    visit "/shelters/#{@raccoon_shelter.id}/#{@review_1.id}/edit"

    click_on 'Submit'

    expect(page).to have_content("Review not Updated: Require information missing.")
    expect(page).to have_button('Submit')
  end
end

# User Story 6, Edit a Shelter Review, cont.
# As a visitor,
# When I fail to enter a title, a rating, and/or content in the edit shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to edit a shelter review
# And I'm returned to the edit form to edit that review


# User Story 5, Edit a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
