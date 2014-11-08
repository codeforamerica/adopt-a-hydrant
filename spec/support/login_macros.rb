module LoginMacros
  def sign_in(user)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_name', with: user.name
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'
  end
end
