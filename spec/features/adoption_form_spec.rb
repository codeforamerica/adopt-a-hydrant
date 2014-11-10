require 'rails_helper'

feature 'Adoption Form', js: true do
  let(:user) { create(:user) }
  before do
    create_list(:thing, 10)
    sign_out
    sign_in user
  end

  scenario 'Opens when a Thing is clicked', js: true do
    find('.thing', match: :first).click

    expect(page).to have_selector '#adoption_form'
  end

end
