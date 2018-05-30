class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: %i(update destroy edit)

  def index
    @products = Product.page(params[:page]).per Settings.products.limit_page
  end

  def edit; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t "flash.create_product_succeed"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "flash.update_product_succeed"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def desroy
    if @product.destroy
      flash[:success] = t "flash.delete_product_succeed"
    else
      flash[:danger] = t "flash.delete_product_failed"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.not_found_product"
    redirect_to admin_products_path
  end
end
