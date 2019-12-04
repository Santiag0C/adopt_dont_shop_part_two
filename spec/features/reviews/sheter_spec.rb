require 'rails_helper'

RSpec.describe "visit /shelters/id show page" do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')
    # binding.pry
    @review_1 = @raccoon_shelter.reviews.create(title: "title 1", rating: 4, content: "content of review 1", picture: 'https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg')
    @review_2 = @raccoon_shelter.reviews.create(title: "title 2", rating: 3, content: "content of review 2")

  end
  it 'can see reviews for a spesific shelter' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content(@review_1.title)
    expect(page).to have_content(@review_1.rating)
    expect(page).to have_content(@review_1.content)
    # expect(page).to have_content(@review_1.picture)
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg']")

    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_2.content)
    # expect(page).to_not  have_content(@review_2.picture)
  end
  it 'should be able to add a review' do

    visit "/shelters/#{@raccoon_shelter.id}"

    click_on 'Create Review'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/review/new")

    fill_in :title, with: 'review title'
    fill_in :rating, with: 4
    fill_in :content, with: 'this product is greate'
    fill_in :picture, with: 'https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg'

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")

    expect(page).to have_content('review title')
    expect(page).to have_content(4)
    expect(page).to have_content('this product is greate')
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg']")

  end
#   User Story 3, Shelter Review Creation
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
end
