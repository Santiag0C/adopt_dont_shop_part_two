require 'rails_helper'

RSpec.describe Favorite, type: :model do
      subject { Favorite.new({'1' => 2, '2' => 3}) }
      describe 'total_count' do
        it 'can calculate the tolat number of items in favs'do

      expect(subject.total_count).to eq(5)
    end
  end

  describe "add to favorites" do
    it "adds a pet to its the favorites" do
      favorites = Favorite.new({
        '1' => 2,
        '2' => 3
      })
      subject.add_favorite(1)
      subject.add_favorite(2)

      expect(subject.total_c).to eq({'1' => 3, '2' => 4})
    end
  end
end
