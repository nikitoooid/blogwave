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

      expect(page).to have_content('Article deleted.')
    end

    it "tries to delete someone else's article" do
      user = create(:user)
      another_user = create(:user)
      article = create(:article, user: another_user)

      sign_in(user)
      visit edit_article_path(article)

      expect(page).to have_content('You are not authorized to perform this action.')
    end
  end

  it 'Unauthenticated user tries to delete article' do
    user = create(:user)
    article = create(:article, user: user)

    visit edit_article_path(article)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(page).to_not have_content('Delete article')
  end
end
