require 'rails_helper'

RSpec.describe 'As a visitor when I visit /shelters/:id', type: :feature do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')
    @dog_shelter = Shelter.create(name: 'Dog Shelter', address: 'Dog Road', city: 'Dog City', state: 'Dog State', zip: '80238')
    @cat_shelter = Shelter.create(name: 'Cat Shelter', address: 'Cat Road', city: 'Cat City', state: 'Cat State', zip: '80239')

    @elena = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Elena', age: 27, sex: 'Female', description: 'This raccoon likes power.', status: 'pending')
    @raccoon = @raccoon_shelter.pets.create(image: 'https://imgix.ranker.com/user_node_img/50070/1001387908/original/1-photo-u1?w=650&q=50&fm=pjpg&fit=crop&crop=faces', name: 'Racccoon', age: 5, sex: 'Male')
    @foxy = @dog_shelter.pets.create(image: 'https://image.pbs.org/video-assets/x1WLcZn-asset-mezzanine-16x9-6kkb4dA.jpg', name: 'Foxy', age: 5, sex: 'Female')
    @goblin = @cat_shelter.pets.create(image: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/02/big-cute-eyes-cat-black-scottish-fold-gimo-1room1cat-fb__700-png.jpg', name: 'Goblin', age: 5, sex: 'Female')

    @raccoon_shelter_review_1 = @raccoon_shelter.reviews.create(title: 'Why is there a raccoon shelter?', rating: 5, content: 'this is awesome', picture: 'https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg')
    @raccoon_shelter_review_2 = @raccoon_shelter.reviews.create!(title: 'This is pointless', rating: 1, content: 'No one should have a raccoon!')
    @dog_shelter_review_1 = @dog_shelter.reviews.create!(title: 'I found my dog foxy here', rating: 4, content: 'Not the dog I thought I was getting, but that is okay.')
  end

  it 'can view all shelter information' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_content(@raccoon_shelter.name)
    expect(page).to have_content("Address: #{@raccoon_shelter.address}")
    expect(page).to have_content("City: #{@raccoon_shelter.city}")
    expect(page).to have_content("State: #{@raccoon_shelter.state}")
    expect(page).to have_content("Zip: #{@raccoon_shelter.zip}")

    visit "/shelters/#{@dog_shelter.id}"

    expect(page).to have_content(@dog_shelter.name)
    expect(page).to have_content("Address: #{@dog_shelter.address}")
    expect(page).to have_content("City: #{@dog_shelter.city}")
    expect(page).to have_content("State: #{@dog_shelter.state}")
    expect(page).to have_content("Zip: #{@dog_shelter.zip}")
  end

  it 'can click on shelter name and go to shelter show page' do
    visit "/shelters/#{@raccoon_shelter.id}"

      within "#shelter-#{@raccoon_shelter.id}" do
        expect(page).to have_link(@raccoon_shelter.name)

        click_on(@raccoon_shelter.name)
  end

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

  it 'when a user visits /shelters/:id there is a link to that shelters pet page /shelters/:id/pets' do
    visit "/shelters/#{@raccoon_shelter.id}"

      expect(page).to have_link('Shelter Pets')

    click_on('Shelter Pets')

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/pets")
  end

  it 'I see a list of reviews with a title, rating, content, and optional picture' do
    visit "/shelters/#{@raccoon_shelter.id}"

    within "#review-#{@raccoon_shelter_review_1.id}" do
      expect(page).to have_content(@raccoon_shelter_review_1.title)
      expect(page).to have_content(@raccoon_shelter_review_1.rating)
      expect(page).to have_content(@raccoon_shelter_review_1.content)
      expect(page).to have_css("img[src*='https://i.dailymail.co.uk/i/pix/2017/11/14/16/4658323800000578-0-image-a-2_1510676236619.jpg']")
    end

    within "#review-#{@raccoon_shelter_review_2.id}" do
      expect(page).to have_content(@raccoon_shelter_review_2.title)
      expect(page).to have_content(@raccoon_shelter_review_2.rating)
      expect(page).to have_content(@raccoon_shelter_review_2.content)
    end

    expect(page).to_not have_content(@dog_shelter_review_1.title)
    expect(page).to_not have_content(@dog_shelter_review_1.rating)
    expect(page).to_not have_content(@dog_shelter_review_1.content)
  end

  it 'There is a fully functinal link to create a new review that redirects to the shelter show page' do
    visit "/shelters/#{@raccoon_shelter.id}"

    expect(page).to have_button('New Review')

    click_on('New Review')

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}/reviews/new")

    title_1 = 'The Best'
    rating_1 = 5
    content_1 = 'I love my new raccoon, seing her grow has been amazing!'
    picture_1 = 'http://howtodoright.com/wp-content/uploads/2017/11/Raccoon-02.jpg'

    fill_in :title, with: title_1
    fill_in :rating, with: rating_1
    fill_in :content, with: content_1
    fill_in :picture, with: picture_1
    # fill_in :picture, with: 'http://howtodoright.com/wp-content/uploads/2017/11/Raccoon-02.jpg'

    click_on 'Submit'
    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")

    expect(page).to have_content(title_1)
    expect(page).to have_content(rating_1)
    expect(page).to have_content(content_1)
    expect(page).to have_css("img[src*='http://howtodoright.com/wp-content/uploads/2017/11/Raccoon-02.jpg']")

    click_on('New Review')

    fill_in :title, with: 'title_2'
    fill_in :rating, with: 4
    fill_in :content, with: 'I do not have a raccoon image'
    fill_in :picture, with: nil

    click_on('Submit')

    expect(current_path).to eq("/shelters/#{@raccoon_shelter.id}")
  end

    it 'can not make a new review if missing title, rating, or content fields, a flash message is shown, and you are redirected to the new form page' do
      visit "/shelters/#{@raccoon_shelter.id}/reviews/new"

      click_on('Submit')

      expect(page).to have_content('Review Not Created! Make Sure To Fill In Title, Rating, And Content!')
      expect(page).to have_button('Submit')
    end
end
