require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "renders index view" do
      user = create(:user)
      create_list(:article, 3, user: user)

      get articles_path
      expect(response).to render_template :index
    end

    it 'returns http success' do
      user = create(:user)
      create_list(:article, 3, user: user)

      get articles_path
      expect(response).to have_http_status :success
    end
  end

  describe 'GET /articles/:id' do
    it "renders article view" do
      user = create(:user)
      article = create(:article, user: user)

      get article_path(article)
      expect(response).to render_template :show
    end

    it 'returns http success' do
      user = create(:user)
      article = create(:article, user: user)

      get article_path(article)
      expect(response).to have_http_status :success
    end
  end

  describe "GET /articles/new" do
    it "renders new article view" do
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

  describe "GET /articles/:id/edit" do
    context 'when user is an author' do
      it "renders edit article view" do
        user = create(:user)
        article = create(:article, user: user)
        sign_in(user)

        get edit_article_path(article)
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        user = create(:user)
        article = create(:article, user: user)
        sign_in(user)

        get edit_article_path(article)
        expect(response).to have_http_status :success
      end
    end

    context 'when user is not an author' do
      it "renders edit article view" do
        user = create(:user)
        another_user = create(:user)
        article = create(:article, user: another_user)
        sign_in(user)

        get edit_article_path(article)
        expect(response).to_not render_template :edit
      end

      it 'returns http success' do
        user = create(:user)
        article = create(:article, user: user)
        sign_in(user)

        get edit_article_path(article)
        expect(response).to have_http_status :success
      end
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

  describe 'PUT /articles/:id' do
    context 'with valid attributes' do
      it 'redirects to article page' do
        user = create(:user)
        article = create(:article, user: user)

        sign_in(user)
        put article_path(article), params: { article: { title: 'New title' } }

        expect(response).to redirect_to(article_path(article))
      end

      it 'edits the article' do
        user = create(:user)
        article = create(:article, user: user)

        sign_in(user)
        put article_path(article), params: { article: { title: 'New title' } }
        follow_redirect!

        expect(response.body).to include('New title')
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit view' do
        user = create(:user)
        article = create(:article, user: user)

        sign_in(user)
        put article_path(article), params: { article: { title: nil } }

        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        article = create(:article, user: user)

        put article_path(article), params: { article: { title: 'New title' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
