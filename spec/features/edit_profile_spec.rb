require 'rails_helper'

shared_examples "user profile form" do
  describe "user info" do
    it "populates the form" do |user|
      within '.sidebar #edit_form.edit_user' do
        user = subject
        expect(page).to have_field 'Email address', with: user.email
        expect(page).to have_field 'Username (visible to others)', with: user.username
        expect(page).to have_field 'Address Line 1', with: user.address_1
        expect(page).to have_field 'Address Line 2', with: user.address_2
        expect(page).to have_field 'City', with: user.city
        expect(page).to have_field 'State', with: user.state
        expect(page).to have_field 'ZIP', with: user.zip
        expect(page).to have_content 'Survey'
        expect(page).to have_field 'user_yob', with: user.yob

        expect(page).to have_field 'user_awareness_code',
          with: user.awareness_code
        expect(page).to have_field 'user_yearsInMinneapolis',
          with: user.yearsInMinneapolis

        if user.gender
          expect(page).to have_checked_field 'user[gender]', with: user.gender
        end

        if user.ethnicity
          expect(page).to have_checked_field 'user[ethnicity][]',
            with: user.ethnicity[0]
        end

        if user.rentOrOwn
          expect(page).to have_checked_field 'user[rentOrOwn]',
            with: user.rentOrOwn
        end

        if user.heardOfAdoptATreeVia
          expect(page).to have_checked_field 'user[heardOfAdoptATreeVia][]',
            with: user.heardOfAdoptATreeVia[0]
        end

        if user.previousTreeWateringExperience
          expect(page).to have_checked_field 'user[previousTreeWateringExperience]',
            with: user.previousTreeWateringExperience
        end

        if user.previousEnvironmentalActivities
          expect(page).to have_checked_field 'user[previousEnvironmentalActivities]',
            with: user.previousEnvironmentalActivities
        end

        if user.valueForestryWork
          expect(page).to have_checked_field 'user[valueForestryWork]',
            with: user.valueForestryWork
        end
      end
    end
  end
end

describe 'Edit Profile', js: true do
  context "New User" do
    subject { create(:user) }

    before do
      sign_in(subject)
      find_link('Edit profile').click
    end

    it_behaves_like "user profile form"
  end

  context "Modified User" do
    subject { create(:modified_profile_user) }

    before do
      sign_in(subject)
      find_link('Edit profile').click
    end

    it_behaves_like "user profile form"
  end
end
