class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: %i(edit update destroy)

  def index
    @products = Product.search(params[:search])
      .page(params[:page]).per Settings.limit_page
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t ".save_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".save_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".update_succeed"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_error"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit Product::ATTR_PARAMS
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".not_found_product"
    redirect_to admin_products_path
  end
end
