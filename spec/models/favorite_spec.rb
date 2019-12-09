require 'rails_helper'
#
RSpec.describe Favorite, type: :model do
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
#   describe 'total_count' do
#     it 'counts all favorites session is holding' do
#       favorite = Favorite.new({1 => 1, 2 => 1})
#       expect(favorite.total_count).to eq(2)
#     end
#   end
  describe 'something' do
    it 'favorite_or_delete method' do

    end
  end
end
