require 'rails_helper'

describe 'Adoption Form', js: true do
  let(:user) { create(:user) }
  before do
    create_list(:thing, 10)
    sign_out
  end

  context 'Not signed in user clicks a thing' do
    before do
      visit root_path
      find('.thing', match: :first).click
    end

    it 'Displays the "Sign in to adopt" message' do
      expect(page).to_not have_selector '#adoption_form'
      expect(page).to have_content 'Sign in to adopt this Tree'
    end
  end

  context 'Signed in user clicks a thing' do
    before do
      sign_out
      sign_in user
      find('.thing', match: :first).trigger('click')
    end

    it 'Opens the "Adopt this Tree" form' do
      expect(page).to have_selector '#adoption_form'
      expect(page).to have_content 'Adopt this Tree'
    end

    context 'Submits the form with no name' do
      before do
        find_button('Adopt!').click
      end

      it 'Displays the "Thank you" message' do
        expect(page).to_not have_content 'Adopt this Tree'
        expect(page).to have_content 'Thank you for adopting this tree!'
      end

      it 'Displays the "Edit Profile" view in the sidebar' do
        within '.sidebar' do
          expect(page).to have_selector 'form#edit_form.edit_user'
        end
      end
    end
  end
end
