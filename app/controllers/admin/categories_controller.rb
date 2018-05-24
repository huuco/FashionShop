class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: %i(update edit destroy)

  def index
    @categories = Category.page(params[:page])
      .per Settings.categories.limit_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = t "flash.create_category_succeed"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.update_category_succeed"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def edit; end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.delete_category_succeed"
    else
      flash[:danger] = t "flash.delete_category_failed"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name, :description, :parent_id
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "flash.not_found_category"
    redirect_to admin_categories_path
  end
end
