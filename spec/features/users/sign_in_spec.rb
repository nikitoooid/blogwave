require 'rails_helper'

describe 'User can sign in', "
  In order create and comment articles
  As an unauthenticated user
  I'd like to be able to sign in
" do
  it 'Unregistred user tries to sign in' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  it 'Registred user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrongemail@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
