class Admin::BrandsController < Admin::BaseController
  before_action :load_brand, only: %i(edit update destroy)

  def index
    @brands = Brand.search_name(params[:search])
                   .page(params[:page])
                   .per Settings.limit_page
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new brand_params

    if @brand.save
      flash[:success] = t ".create_succeed"
      redirect_to admin_brands_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @brand.update_attributes brand_params
      flash[:success] = t ".update_succeed"
      redirect_to admin_brands_path
    else
      flash[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @brand.products.empty? && @brand.destroy
      flash[:success] = t ".delete_succeed"
    else
      flash[:danger] = t ".can't_not"
    end
      redirect_to admin_brands_path
  end

  private

  def brand_params
    params.require(:brand).permit :name, :description
  end

  def load_brand
    @brand = Brand.find_by id: params[:id]
    return if @brand
    flash[:danger] = t ".not_found_brand"
    redirect_to admin_brands_path
  end
end
