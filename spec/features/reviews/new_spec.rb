require 'rails_helper'

RSpec.describe "new review" do
  before(:each) do
    @raccoon_shelter = Shelter.create(name: 'Raccoon Shelter', address: 'Raccoon Road', city: 'Raccoon State', state: 'Raccoon City', zip: '80237')

  end
  it "can not create a review without filing in all the info" do
    visit"/shelters/#{@raccoon_shelter.id}/review/new"

    click_on 'Submit'

    expect(page).to have_content("Review not created: Require information missing.")
    expect(page).to have_button('Submit')
  end
end
