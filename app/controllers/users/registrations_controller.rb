class Users::RegistrationsController < Devise::RegistrationsController

def new
  @user = User.new
  @prefectures = Prefecture.all
end

  def create
    begin
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
    rescue => exception
    redirect_to root path
    end
  end

  def create_address
    begin
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    rescue => exception
    redirect_to root path
    end
  end

  protected

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :street, :building_name, :telehone_number)
  end

end
