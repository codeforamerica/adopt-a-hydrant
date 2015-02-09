module LoginMacros
  def sign_in(user)
    visit root_path
    fill_in 'user_email', with: user.email
    find('#user_existing').click
    # wait for animation
    sleep 0.5
    fill_in 'user_password', with: user.password
    find_button('Sign in').click
  end

  def sign_up(user)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_username', with: user.username
    fill_in 'user_first_name', with: user.first_name
    fill_in 'user_last_name', with: user.last_name
    fill_in 'user_address_1', with: user.address_1
    fill_in 'user_city', with: user.city
    find(:select, 'user_state').find(:xpath, "option[@value='#{user.state}']").select_option
    fill_in 'user_zip', with: user.zip
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'
  end

  def sign_out
    if page.has_button? '#sign_out_link'
      click_button 'Sign out'
    end
  end
end
