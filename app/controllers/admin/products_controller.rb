class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: %i(edit update destroy active)

  def index
    @products = Product.search_admin(params[:search])
      .page(params[:page]).per Settings.limit_page
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t ".create_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".update_success"
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
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_products_path
  end

  def active
    @product.update_attributes active: params[:active]
    respond_to do |format|
      format.json
    end
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
