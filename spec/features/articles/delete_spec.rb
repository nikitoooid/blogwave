require 'rails_helper'

describe 'User can delete an article', "
In order to remove my article
As an uthenticated author
I'd like to be able to delete an article
" do
  describe 'Authenticated user' do
    it 'tries to delete his article' do
      user = create(:user)
      article = create(:article, user: user)

      sign_in(user)
      visit edit_article_path(article)
      click_on 'Delete article'

      expect(page).to have_content(I18n.t('articles.destroy.success'))
    end

    it "tries to delete someone else's article" do
      user = create(:user)
      another_user = create(:user)
      article = create(:article, user: another_user)

      sign_in(user)
      visit edit_article_path(article)

      expect(page).to have_content(I18n.t('articles.failure.no_rights'))
    end
  end

  it 'Unauthenticated user tries to delete article' do
    user = create(:user)
    article = create(:article, user: user)

    visit edit_article_path(article)

    expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    expect(page).to_not have_content(I18n.t('articles.edit.delete'))
  end
end
