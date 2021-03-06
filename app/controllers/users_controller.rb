class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
      session[:session_token] = @user.session_token
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user ||= User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
