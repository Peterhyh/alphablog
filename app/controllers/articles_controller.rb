class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ] # before_action method now triggers set_article for only show, edit, update, and destroy
  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was saved successfully."
      redirect_to @article # Redirects to the show controller above.
    else
      render :new, status: :unprocessable_entity # This is used instead of 'render "new"'
    end
  end

  def update
    if @article.update(params.require(:article).permit(:title, :description)) # Whitelist title and description to be used. 'params.require(:article).permit(:title, :description'
      flash[:notice] = "Article was updated successfully"
      redirect_to @article # Redirects to the articles show path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private # Indicates the methods below it is privately for this file only.

  def set_article
    @article = Article.find(params[:id])
  end
end
