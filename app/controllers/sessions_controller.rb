class SessionsController < ApplicationController

  def new
    redirect_to user_url(current_user) if logged_in?
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    @user = User.new
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
