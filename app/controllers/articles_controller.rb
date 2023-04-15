class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @article = Article.with_attached_cover_image.find(params[:id])
  end

  def new
    @article = Article.new
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

  private

  def article_params
    params.require(:article).permit(:title, :content, :cover_image)
  end
end
