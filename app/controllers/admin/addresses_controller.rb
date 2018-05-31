class Admin::AddressesController < Admin::BaseController
  before_action :find_address, only: %i(update destroy edit)

  def index
    @addresses = Address.page(params[:page]).per Settings.limit_page
  end

  def edit; end

  def update
    if @address.update address_params
      flash[:success] = t ".save_success"
      redirect_to admin_addresses_path
    else
      render :new
    end
  end

  def create
    @address = Address.new address_params

    if @address.save
      flash[:success] = t ".save_success"
      redirect_to admin_addresses_path
    else
      render :new
    end
  end

  def new
    @address = Address.new
  end

  def destroy
    if @address.destroy
      flash[:success] = t(".delete_success")
    else
      flash[:warning] = t(".delete_error")
    end
    redirect_to admin_addresses_path
  end

  private

  def address_params
    params.require(:address).permit Address::ADDRESS_PARAMS
  end

  def find_address
    @address = Address.find_by id: params[:id]
    return if @address
    flash[:danger] = t ".address_not_found"
    redirect_to admin_addresses_path
  end
end
