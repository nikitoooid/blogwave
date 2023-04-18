class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update]

  def index
    @articles = Article.all
  end

  def show
    
  end

  def new
    @article = Article.new
  end

  def edit
    authorize_author!
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to article_path(@article), notice: 'Article was successfully created.'
    else
      flash.now[:alert] = 'Article is not created!'
      render :new
    end
  end

  def update
    authorize_author!

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully edited.'
    else
      flash.now[:alert] = 'Article is not edited!'
      render :edit
    end
  end

  private

  def set_article
    @article = Article.with_attached_cover_image
                        .with_rich_text_content_and_embeds
                          .includes(:user).find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :cover_image)
  end

  def authorize_author!
    return if current_user&.author_of?(@article)
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
