class AddressesController < ApplicationController
  before_action :load_address, only: %i(update destroy edit)

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build address_params
    if @address.save
      flash[:success] = t "addresses.save_success"
      redirect_to addresses_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update_attributes address_params
      flash[:success] = t "addresses.save_success"
      redirect_to addresses_path
    else
      render :new
    end
  end

  def destroy
    if @address.destroy
      flash[:success] = t "addresses.delete_success"
    else
      flash[:warning] = t "addresses.delete_error"
    end
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit Address::FRONT_ADDRESS_PARAMS
  end

  def load_address
    @address = Address.find_by id: params[:id]
    return if @address
    flash[:danger] = t "addresses.address_not_found"
    redirect_to addresses_path
  end
end
