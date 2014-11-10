require 'rails_helper'

describe 'Combo Form' do
  before do
    visit root_path
  end

  let(:user) { build(:user) }

  context 'Home page combo form' do
    it 'shows email, name, and password fields' do
      within '#combo-form' do
        sign_up_button = page.find_button 'Sign up'

        expect(page).to have_field 'user_email'
        expect(page).to have_field 'user_name'
        expect(page).to have_field 'user_password_confirmation'
        expect(sign_up_button).to_not be_disabled
      end
    end
  end

  context 'Invalid sign up' do
    it 'does not sign up with invalid email address', js: true do
      within '#combo-form' do
        fill_in 'user_email', with: 'invalid@aol'
        fill_in 'user_name', with: user.name
        fill_in 'user_password_confirmation', with: user.password
        click_button 'Sign up'

        expect(page).to have_button 'Sign up'
        expect(page).to have_selector '.control-group.error #user_email'
      end
    end

    it 'does not sign up with invalid password', js: true do
      within '#combo-form' do
        fill_in 'user_email', with: user.email
        fill_in 'user_name', with: user.name
        fill_in 'user_password_confirmation', with: 'derp'
        click_button 'Sign up'

        expect(page).to have_button 'Sign up'
        expect(page).to have_selector(
          '.control-group.error #user_password_confirmation')
      end
    end

    it 'does not sign up with no name', js: true do
      within '#combo-form' do
        fill_in 'user_email', with: user.email
        fill_in 'user_password_confirmation', with: user.password
        click_button 'Sign up'

        expect(page).to have_button 'Sign up'
        expect(page).to have_selector '.control-group.error #user_name'
      end
    end
  end

  context 'Successful sign up', js: true do
    it 'displays a "Thanks" message' do
      sign_up user

      within '.sidebar' do
        expect(page).to have_text 'Thanks for signing up!'
        expect(page).to_not have_selector '#combo-form'
      end
    end
  end
end
