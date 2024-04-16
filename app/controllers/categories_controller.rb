class CategoriesController < ApplicationController
  def index

  end

  def show
    @category=Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  # def edit
  #
  # end
  # def update
  #
  # end

  private
  def category_params
    # params[:article]
    params.require(:category).permit(:name)
  end
end