require 'rails_helper'

describe 'User can view articles', "
  In order to see articles from other users
  As user
  I'd like to be able to view articles on the index page
" do
  it 'Authenticated user tries to see all articles' do
    user = create(:user)
    articles = create_list(:article, 3, user: user)

    sign_in user
    visit articles_path

    articles.each do |article|
      expect(page).to have_css("#article_#{article.id}")
    end
  end

  it 'Unauthenticated user tries to see all articles' do
    user = create(:user)
    articles = create_list(:article, 3, user: user)

    visit articles_path

    articles.each do |article|
      expect(page).to have_css("#article_#{article.id}")
    end
  end
end
