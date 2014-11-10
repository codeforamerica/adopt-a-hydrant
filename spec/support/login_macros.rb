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
    fill_in 'user_name', with: user.name
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'
  end

  def sign_out
    if page.has_button? '#sign_out_link'
      click_button 'Sign out'
    end
  end
end
