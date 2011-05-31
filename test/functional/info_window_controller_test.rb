require 'test_helper'

class InfoWindowControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @hydrant = hydrants(:hydrant_1)
    @user = users(:erik)
  end

  test 'should thank the user if the user the hydrant is adopted by the user' do
    sign_in @user
    @hydrant.user_id = @user.id
    @hydrant.save!
    get :index, :hydrant_id => @hydrant.id
    assert_not_nil assigns :hydrant
    assert_response :success
    assert_template 'users/thank_you'
    assert_select 'h2', 'Thank you for adopting this hydrant!'
    assert_select 'form#edit_profile_form' do
      assert_select '[action=?]', '/users/edit'
      assert_select '[method=?]', 'get'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Edit profile'
    end
    assert_select 'form#abandon_form' do
      assert_select '[action=?]', "/hydrants"
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="_method"]' do
      assert_select '[type=?]', 'hidden'
      assert_select '[value=?]', 'put'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Abandon this hydrant'
    end
    assert_select 'form#sign_out_form' do
      assert_select '[action=?]', '/info_window'
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Sign out'
    end
  end

  test 'should show the profile if the hydrant is adopted' do
    @hydrant.user_id = @user.id
    @hydrant.save!
    get :index, :hydrant_id => @hydrant.id
    assert_not_nil assigns :hydrant
    assert_response :success
    assert_template 'users/profile'
    assert_select 'h2', "This hydrant has been adopted by #{@user.name}"
    assert_select 'h3', "of #{@user.organization}"
  end

  test 'should show adoption form if hydrant is not adopted' do
    sign_in @user
    get :index, :hydrant_id => @hydrant.id
    assert_not_nil assigns :hydrant
    assert_response :success
    assert_template :adopt
    assert_select 'h2', 'Adopt this Hydrant'
    assert_select 'form#adoption_form' do
      assert_select '[action=?]', "/hydrants"
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="_method"]' do
      assert_select '[type=?]', 'hidden'
      assert_select '[value=?]', 'put'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Adopt!'
    end
    assert_select 'form#edit_profile_form' do
      assert_select '[action=?]', '/users/edit'
      assert_select '[method=?]', 'get'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Edit profile'
    end
    assert_select 'form#sign_out_form' do
      assert_select '[action=?]', '/info_window'
      assert_select '[method=?]', 'post'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Sign out'
    end
  end

  test 'should show sign-in form if signed out' do
    get :index, :hydrant_id => @hydrant.id
    assert_not_nil assigns :hydrant
    assert_response :success
    assert_template 'sessions/new'
    assert_select 'form#combo_form' do
      assert_select '[action=?]', '/info_window'
      assert_select '[method=?]', 'post'
    end
    assert_select 'h2', 'Adopt this Hydrant'
    assert_select 'input', :count => 15
    assert_select 'label', :count => 10
    assert_select 'input[name="commit"]', :count => 3
  end
end
