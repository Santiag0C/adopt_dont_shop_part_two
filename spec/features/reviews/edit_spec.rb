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

  it 'completely functional edit link next each shelter review with a prepopulated form ' do
    visit "/shelters/#{@raccoon_shelter.id}"

    # within "#review-#{@raccoon_shelter_review_1.id}" do
    #   expect(page).to have_link('Edit Review')
    #
    #   click_on('Edit Review')
    # end
    # expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/reviews/#{@raccoon_shelter_review_1.id}/edit")
    #
    # click_on 'Submit'
    #
    # expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
    #
    # expect(page).to have_content(@raccoon_shelter_review_1.title)
    # expect(page).to have_content(@raccoon_shelter_review_1.rating)
    # expect(page).to have_content(@raccoon_shelter_review_1.content)
    # expect(page).to have_css("img[src*='https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg']")

    within "#review-#{@raccoon_shelter_review_1.id}" do
      click_on('Edit Review')
    end

   expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/reviews/#{@raccoon_shelter_review_1.id}/edit")

    title = 'New Title'
    rating = 2
    content = 'New Content'
    picture = 'https://i1.wp.com/metro.co.uk/wp-content/uploads/2019/03/sei_54738239-dee9.jpg?quality=90&strip=all&zoom=1&resize=644%2C428&ssl=1'

    fill_in :title, with: title
    fill_in :rating, with: rating
    fill_in :content, with: content
    fill_in :picture, with: picture

    click_on('Submit')

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")

    expect(page).to have_content(title)
    expect(page).to have_content(rating)
    expect(page).to have_content(content)
    expect(page).to have_css("img[src*='https://i1.wp.com/metro.co.uk/wp-content/uploads/2019/03/sei_54738239-dee9.jpg?quality=90&strip=all&zoom=1&resize=644%2C428&ssl=1']")
  end

    it 'If title, rating, or content are not filled in there is a flash message and a redirect to review edit form' do
      visit "/shelters/#{@raccoon_shelter.id}"

      within "#review-#{@raccoon_shelter_review_1.id}" do
        click_on('Edit Review')
      end

      click_on 'Submit'

      expect(page).to have_content('Review Not Created! Make Sure To Fill In Title, Rating, And Content!')
      expect(page).to have_button('Submit')
    end
end
