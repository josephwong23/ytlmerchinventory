class CategoriesController < ApplicationController
  def create
    category = Category.new(category_params)
    if category.save
      render :json => {:response => category}
    else
      render :status => 400
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
