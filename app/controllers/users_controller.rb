class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:success] = "Welcome: #{@user.email}"
    else
      if(User.find_by(email: @user.email))
        flash[:danger] = "An account is already associated with this email address"
      elsif(@user.email.empty?)
        flash[:danger] = "You must enter an email address."
      elsif(@user.password_digest.nil?)
        flash[:danger] = "You must enter a password."
      elsif(@user.password_confirmation.empty?)
        flash[:danger] = "Password confirmation must match the password. Password confirmation can't be blank."
      elsif(@user.password != @user.password_confirmation)
        flash[:danger] = "Password confirmation must match the password."
      end

      redirect_to new_user_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
