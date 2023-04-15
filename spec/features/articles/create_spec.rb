require 'rails_helper'

describe 'User can add an article', "
  In order to share my thoughts
  As an authenticated user
  I'd like to be able to add an article
" do
  describe 'Authenticated user tries to add an article' do
    it 'with valid params' do
      user = create(:user)
      sign_in(user)

      visit new_article_path
      fill_in 'article[title]', with: 'My First Article'
      attach_file 'article[cover_image]', Rails.public_path.join('apple-touch-icon.png')
      click_button 'Create Article'

      expect(page).to have_content 'Article was successfully created.'
      expect(page).to have_content 'My First Article'
      expect(page).to have_css '.cover-image'
    end

    it 'with invalid params' do
      user = create(:user)
      sign_in(user)

      visit new_article_path
      click_button 'Create Article'

      expect(page).to have_content 'Article is not created!'
      expect(page).to_not have_css '.cover-image'
    end
  end

  it 'Unauthenticated user tries to add an article' do
    visit new_article_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
