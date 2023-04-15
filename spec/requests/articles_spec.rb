require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /index" do
  end

  describe "GET /articles/new" do
    it "renders a new article form" do
      user = create(:user)
      sign_in(user)

      get new_article_path
      expect(response).to render_template :new
    end

    it 'returns http success' do
      user = create(:user)
      sign_in(user)

      get new_article_path
      expect(response).to have_http_status :success
    end
  end

  describe "POST /articles" do
    context "with valid parameters" do
      it 'creates a new article' do
        user = create(:user)
        article_params = { article: attributes_for(:article, user: user) }
        sign_in(user)

        expect { post articles_path, params: article_params }.to change(Article, :count).by(1)
      end

      it 'returns http found' do
        user = create(:user)
        article_params = { article: attributes_for(:article, user: user) }
        sign_in(user)

        post articles_path, params: article_params
        expect(response).to have_http_status(:found)
      end

      it 'redirects to article page' do
        user = create(:user)
        article_params = { article: attributes_for(:article, user: user) }
        sign_in(user)

        post articles_path, params: article_params

        expect(response).to redirect_to(article_path(Article.last))
      end
    end

    context "with invalid parameters" do
      it 'does not create a new article' do
        user = create(:user)
        article_params = { article: attributes_for(:article, :invalid, user: user) }
        sign_in(user)

        expect { post articles_path, params: article_params }.to_not change(Article, :count)
      end

      it 'renders new view' do
        user = create(:user)
        article_params = { article: attributes_for(:article, :invalid, user: user) }
        sign_in(user)

        post articles_path, params: article_params

        expect(response).to render_template :new
      end

      it 'returns http success' do
        user = create(:user)
        article_params = { article: attributes_for(:article, :invalid, user: user) }
        sign_in(user)

        post articles_path, params: article_params

        expect(response).to have_http_status :success
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        article_params = { article: attributes_for(:article, user: user) }

        post articles_path, params: article_params

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
