require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    # it {should validate_presence_of :picture}
    it {should have_db_column(:picture).of_type(:string).with_options(default: nil, options: true)}


      # it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end
end
