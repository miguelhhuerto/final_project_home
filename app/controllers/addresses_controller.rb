class AddressesController < ApplicationController
  before_action :set_user
  before_action :set_address, only: [:edit, :update, :destroy]

  def index;
    @addresses = @user.addresses
  end

  def new;
    @address = @user.addresses.build
  end

  def create
    @address = @user.addresses.build(address_params)
    if @address.save
      flash[:notice] = 'Address created successfully'
      redirect_to user_addresses_path(@user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      flash[:notice] = 'Address updated successfully'
      redirect_to user_addresses_path(@user)
    else
      flash.now[:alert] = 'Address update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Address destroyed successfully'
    redirect_to user_addresses_path(@user)
  end

  private

  def set_user
    @user = current_user
  end

  def set_address
    @address = @user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:user_id, :genre, :name, :street_address, :phone_number, :remark, :is_default, :address_region_id, :address_province_id,:address_city_id,:address_barangay_id)
  end
end
