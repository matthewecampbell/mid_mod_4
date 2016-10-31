class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account Created."
      redirect_to links_path
    else
      flash.now[:warning] = "Email is already used or password does not match."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
