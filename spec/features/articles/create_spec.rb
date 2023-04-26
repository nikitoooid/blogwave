require 'rails_helper'

describe 'User can create an article', "
  In order to share my thoughts
  As an authenticated user
  I'd like to be able to create an article
" do
  describe 'Authenticated user tries to create an article' do
    it 'with valid params' do
      user = create(:user)
      sign_in(user)

      visit new_article_path
      fill_in 'article[title]', with: 'My First Article'
      attach_file 'article[cover_image]', Rails.public_path.join('apple-touch-icon.png')
      click_button I18n.t('articles.new.save')

      expect(page).to have_content I18n.t('articles.create.success')
      expect(page).to have_content 'My First Article'
      expect(page).to have_css '.cover-image'
    end

    it 'with invalid params' do
      user = create(:user)
      sign_in(user)

      visit new_article_path
      click_button I18n.t('articles.new.save')

      expect(page).to have_content I18n.t('articles.create.error')
      expect(page).to_not have_css '.cover-image'
    end
  end

  it 'Unauthenticated user tries to create an article' do
    visit new_article_path

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
