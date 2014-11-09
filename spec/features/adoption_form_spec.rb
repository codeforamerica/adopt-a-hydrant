require 'rails_helper'

feature 'Adoption Form', js: true do
  let(:user) { create(:user) }
  before do
    create_list(:thing, 10)
  end

  scenario 'Opens when a Thing is clicked', js: true do
    sign_in user
    find('form#address_form')
    find('.thing', match: :first).click

    expect(page).to have_selector '#adoption_form'
  end

end
