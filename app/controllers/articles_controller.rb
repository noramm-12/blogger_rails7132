# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  def show
    # byebug
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    # render plain: params[:article]
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article was created successfully.' # sending success message by flash
      redirect_to article_path(@article) # prefix:article => show.html.erb
    else
      render 'new' # new.html erb
    end

    # render plain: @article.inspect
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was edited successfully.' # sending success message by flash
      redirect_to article_path(@article) # show
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path # prefix:articles => index.html.erb
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
