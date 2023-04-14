require 'rails_helper'

describe 'User can sign up', "
  In order create and comment articles
  As an unauthenticated user
  I'd like to be able to sign up
" do
  it 'Unregistred user tries to sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    within 'main' do
      click_on 'Sign up'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'Registred user tries to sign up' do
    user = create(:user)

    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    within 'main' do
      click_on 'Sign up'
    end

    expect(page).to have_content 'prohibited this user from being saved'
  end
end
