require 'rails_helper'

describe 'User can edit articles', "
  In order to change information
  As an author
  I'd like to be able to edit my articles
" do
  describe 'Authenticated user' do
    it 'tries to edit his article' do
      user = create(:user)
      article = create(:article, user: user)

      sign_in(user)
      visit edit_article_path(article)

      fill_in 'article[title]', with: 'This is new title'
      click_button I18n.t('articles.edit.save')

      expect(page).to have_content('This is new title')
    end

    it "tries to edit someone else's article" do
      user = create(:user)
      another_user = create(:user)
      article = create(:article, user: another_user)

      sign_in(user)
      visit edit_article_path(article)

      expect(page).to have_content(I18n.t('articles.failure.no_rights'))
    end
  end

  it 'Unauthenticated user tries to edit article' do
    user = create(:user)
    article = create(:article, user: user)

    visit edit_article_path(article)

    expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
  end
end
