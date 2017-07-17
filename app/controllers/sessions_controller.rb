class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:success] = "Welcome back, #{@user.email}"
    else
      redirect_to login_path
      flash[:danger] = "Login failed, make sure your email and password are correct."
    end
  end

  def destroy
    session.clear
    redirect_to root_path
    flash[:success] = 'You have successfully logged out!'
  end

end
