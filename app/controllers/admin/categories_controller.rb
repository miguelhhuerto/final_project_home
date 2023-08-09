class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :items_with_category, only: [:destroy]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category updated successfully'
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if items_with_category.empty?
      @category.destroy
      flash[:notice] = 'Category deleted successfully'
    else
      flash[:alert] = 'Selected Category cannot be deleted. It is associated with an Item '
    end
    redirect_to admin_categories_path
  end



  private

  def items_with_category
    @category.items
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
        has_many :categories, through: :item_category_ships
  end
end