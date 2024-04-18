# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article]
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully.' # sending success message by flash
      redirect_to article_path(@article) # prefix:article => show.html.erb
      # redirect_to @article
    else
      render 'new', status: :unprocessable_entity # new.html erb
    end

    # render plain: @article.inspect
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was edited successfully.' # sending success message by flash
      redirect_to article_path(@article) # show
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path # prefix:articles => index.html.erb
  end

  private

  def article_params
    # params[:article]
    params.require(:article).permit(:title, :description, category_ids:[])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = 'You can only edit or delete your own article'
      redirect_to @article
    end
  end
end
